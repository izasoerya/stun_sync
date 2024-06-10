import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:stun_sync/models/user_profile.dart';
import 'package:stun_sync/service/user_profile_controller.dart';

class SQLiteDB {
  const SQLiteDB();

  Future<String> getPathDB() async {
    String path = await getDatabasesPath();
    return join(path, 'stun_sync.db');
  }

  Future<bool> isTableExists(DatabaseExecutor db, String table) async {
    var count = firstIntValue(await db.query('sqlite_master',
        columns: ['COUNT(*)'],
        where: 'type = ? AND name = ?',
        whereArgs: ['table', table]));
    return count! > 0;
  }

  Future<Database> openDB() async {
    String path = await getPathDB();
    Database database =
        await openDatabase(path, version: 1, onCreate: (db, version) {
      db.execute('''
        CREATE TABLE user_profile(
          id INTEGER PRIMARY KEY,
          name TEXT,
          password TEXT,
          height INTEGER,
          weight INTEGER,
          age INTEGER,
          lingkar_kepala INTEGER,
          lingkar_dada INTEGER,
          admin TEXT,
          datetime TEXT
        )
      ''');
    });
    return database;
  }

  Future<void> showTables(Database db) async {
    List<Map<String, dynamic>> tables = await db.rawQuery(
      'SELECT * FROM sqlite_master WHERE type = "table"',
    );
    for (var element in tables) {
      print(element);
    }
  }

  Future<void> showUserProfileTable(Database db) async {
    List<Map<String, dynamic>> userProfiles = await db.query('user_profile');

    for (var userProfile in userProfiles) {
      print(userProfile);
    }
  }

  Future<List<Map<String, dynamic>>> showAllUsers(Database db) async {
    List<Map<String, dynamic>> users = await db.query('user_profile');
    return users;
  }

  Future<void> insertUser(Database db, UserProfile user) async {
    await db.insert('user_profile', {
      'name': user.name,
      'password': user.password,
      'height': user.height,
      'weight': user.weight,
      'age': user.age,
      'lingkar_kepala': user.lingkarKepala,
      'lingkar_dada': user.lingkarDada,
      'admin': user.admin.toString(),
      'datetime': user.datetime.toString(),
    });
  }

  Future<void> deleteUser(Database db, {int? id, String? name}) async {
    if (id != null) {
      await db.delete(
        'user_profile',
        where: 'id = ?',
        whereArgs: [id],
      );
    } else if (name != null) {
      await db.delete(
        'user_profile',
        where: 'name = ?',
        whereArgs: [name],
      );
    } else {
      throw ArgumentError('You must provide either id or name');
    }
  }

  Future<bool> searchUserbyUsernamePassword(
      Database db, String name, String password, bool admin) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'user_profile',
      where: 'name = ? AND password = ? AND admin = ?',
      whereArgs: [name, password, admin.toString()],
    );

    return maps.isNotEmpty;
  }

  Future<List<UserProfile>> getUserByCredential(
      Database db, String name, String password, bool admin) async {
    var users = await db.query('user_profile',
        where: 'name = ? AND password = ? AND admin = ?',
        whereArgs: [name, password, admin.toString()]);

    List<UserProfile> userProfiles = users.isNotEmpty
        ? users.map((user) {
            // Safely cast datetime to String and handle null or incorrect types
            String? datetimeString = user['datetime'] as String?;
            DateTime? datetime;
            if (datetimeString != null) {
              try {
                datetime = DateTime.parse(datetimeString);
              } catch (e) {
                // Handle the case where the string is not a valid datetime format
                // For example, log the error or set datetime to null
              }
            }

            return UserProfile(
              name: user['name'] as String,
              password: user['password'] as String,
              age: user['age'] as int,
              height: user['height'] as int,
              weight: user['weight'] as int,
              lingkarKepala: user['lingkar_kepala'] as int,
              lingkarDada: user['lingkar_dada'] as int,
              admin: (user['admin'] as String?) == 'true',
              datetime: datetime!, // Use the safely parsed DateTime or null
            );
          }).toList() // Convert the result of map to a List
        : [];
    return userProfiles;
  }

  Future<void> updateUserHeight(
      Database db, String name, double newHeight) async {
    await db.update(
      'user_profile',
      {'height': newHeight},
      where: 'name = ?',
      whereArgs: [name],
    );
  }

  Future<void> updateUserData(Database db, UserProfile user) async {
    await db.update(
      'user_profile',
      {
        'name': user.name,
        'password': user.password,
        'height': user.height,
        'weight': user.weight,
        'age': user.age,
        'lingkar_kepala': user.lingkarKepala,
        'lingkar_dada': user.lingkarDada,
        'admin': user.admin.toString(),
        'datetime': user.datetime.toString(),
      },
      where: 'name = ?',
      whereArgs: [user.name],
    );
  }

  Future<UserProfile?> getUserByNameAndPassword(
      Database db, String name, String password) async {
    const String sql = '''
      SELECT * FROM user_profile 
      WHERE name = ? AND password = ? 
      ORDER BY id DESC
      LIMIT 1;
    ''';
    final List<Map<String, dynamic>> result =
        await db.rawQuery(sql, [name, password]);
    if (result.isNotEmpty) {
      return UserProfile(
        name: result.first['name'],
        password: result.first['password'],
        age: result.first['age'],
        height: result.first['height'],
        weight: result.first['weight'],
        lingkarKepala: result.first['lingkar_kepala'],
        lingkarDada: result.first['lingkar_dada'],
        admin: result.first['admin'] == 'true' ? true : false,
        datetime: DateTime.parse(result.first['datetime']),
      );
    }
    return null;
  }

  Future<void> closeDB(Database db) async {
    await db.close();
  }

  Future<void> deleteDB() async {
    String path = await getPathDB();
    await deleteDatabase(path);
    print('deleted database at $path');
  }

  Future<List<String>> getTables(Database db) async {
    final List<Map<String, dynamic>> tables =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    return tables.map((row) => row['name'] as String).toList();
  }

  Future<void> convertDbToExcel(String dbPath, String excelFilePath) async {
    var db = await openDatabase(dbPath);
    var excel = Excel.createExcel(); // Create a new Excel document

    // Get the list of tables
    List<String> tables = await getTables(db);

    for (String table in tables) {
      // Create a new sheet for each table
      Sheet sheet = excel[table];
      // Query all rows in the current table
      List<Map<String, dynamic>> rows = await db.query(table);
      if (rows.isNotEmpty) {
        // Write column headers
        sheet.appendRow(
            rows.first.keys.map((key) => TextCellValue(key)).toList());

        // Write data rows
        for (var row in rows) {
          sheet.appendRow(row.values
              .map((value) => TextCellValue(value.toString()))
              .toList());
        }
      }
    }

    // Save the Excel file
    var fileBytes = excel.save();
    File(excelFilePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    // Close the database
    await db.close();
  }

  Future<void> downloadDB() async {
    try {
      // Check if the source file exists
      String dbFilePath = await getPathDB();

      // Define the path to the Downloads directory, adding a new folder 'stun_sync'
      String downloadPath = '/storage/emulated/0/Download/stun_sync';

      // Create the new directory if it doesn't exist
      Directory newDirectory = Directory(downloadPath);
      if (!await newDirectory.exists()) {
        await newDirectory.create(
            recursive:
                true); // Creates the directory and any non-existent parent directories
      }

      // Construct the path for the Excel file within the new folder
      String excelFilePath = join(newDirectory.path, 'stun_sync_data.xlsx');

      // Convert the database to an Excel file
      await convertDbToExcel(dbFilePath, excelFilePath);
    } on FileSystemException catch (e) {
      throw Exception('File system error: $e');
    } catch (e) {
      throw Exception('Error downloading database: $e');
    }
  }

  Future<void> parseMQTTData(Map<String, dynamic> mqttData) async {
    try {
      Database db = await openDB();
      String currentDate = DateTime.now()
          .toString()
          .substring(0, 10); // Get current date in yyyy-mm-dd format
      currentDate = currentDate.replaceAll('-', '_'); // Replace '-' with '_'
      bool tableExists = await isTableExists(db, 'user_profile');

      if (tableExists) {
        // Table exists for current date, update height and weight
        await db.rawUpdate(
          'UPDATE user_profile_$currentDate SET height = ?, weight = ?',
          [mqttData['height'], mqttData['weight']],
        );
        print('Updated height and weight for $currentDate');
      } else {
        // Table doesn't exist for current date, create new table and insert data
        await db.execute('''
        CREATE TABLE user_profile_$currentDate(
          id INTEGER PRIMARY KEY,
          name TEXT,
          password TEXT,
          height INTEGER,
          weight INTEGER,
          age INTEGER,
          lingkar_kepala INTEGER,
          lingkar_dada INTEGER,
          admin TEXT,
          datetime TEXT
        )
      ''');
        await db.rawInsert(
          'INSERT INTO user_profile_$currentDate (height, weight, datetime) VALUES (?, ?, ?)',
          [mqttData['height'], mqttData['weight'], currentDate],
        );
        print('Created new table for $currentDate and inserted height, weight');
      }
      await db.close();
    } catch (e) {
      print('Error parsing MQTT data: $e');
    }
  }
}
