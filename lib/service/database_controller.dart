import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:stun_sync/models/user_profile.dart';

class SQLiteDB {
  const SQLiteDB();

  Future<String> getPathDB() async {
    String path = await getDatabasesPath();
    return join(path, 'stun_sync.db');
  }

  Future<bool> isTableExists(String table) async {
    final Database db = await openDB();
    var count = firstIntValue(await db.query('sqlite_master',
        columns: ['COUNT(*)'],
        where: 'type = ? AND name = ?',
        whereArgs: ['table', table]));
    await db.close();
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
          height FLOAT, 
          weight FLOAT,
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

  Future<void> showTables() async {
    final Database db = await openDB();
    List<Map<String, dynamic>> tables = await db.rawQuery(
      'SELECT * FROM sqlite_master WHERE type = "table"',
    );
    for (var element in tables) {
      print(element);
    }
    await db.close();
  }

  Future<void> showUserProfileTable() async {
    final Database db = await openDB();
    List<Map<String, dynamic>> userProfiles = await db.query('user_profile');

    for (var userProfile in userProfiles) {
      print(userProfile);
    }
    await db.close();
  }

  Future<List<Map<String, dynamic>>> showAllUsers() async {
    final Database db = await openDB();
    List<Map<String, dynamic>> users = await db.query('user_profile');
    await db.close();
    return users;
  }

  Future<void> insertUser(UserProfile user) async {
    final Database db = await openDB();
    await db.insert('user_profile', {
      'name': user.name,
      'password': user.password,
      'height': user.height,
      'weight': user.weight,
      'age': user.age,
      'lingkar_kepala': user.lingkarKepala,
      'lingkar_dada': user.lingkarDada,
      'admin': user.admin.toString(),
      'datetime': user.datetime.toString().length >= 10
          ? user.datetime.toString().substring(0, 10)
          : user.datetime.toString(),
    });
    await db.close();
  }

  Future<void> deleteUser({int? id, String? name}) async {
    final Database db = await openDB();
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
    await db.close();
  }

  Future<bool> searchUserbyUsernamePassword(
      String name, String password, bool admin) async {
    final Database db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'user_profile',
      where: 'name = ? AND password = ? AND admin = ?',
      whereArgs: [name, password, admin.toString()],
    );
    await db.close();
    return maps.isNotEmpty;
  }

  Future<List<UserProfile>> getUserByCredential(
      String name, String password, bool admin) async {
    final Database db = await openDB();
    var users = await db.query('user_profile',
        where: 'name = ? AND password = ? AND admin = ?',
        whereArgs: [name, password, admin.toString()]);

    List<UserProfile> userProfiles = users.isNotEmpty
        ? users.map((user) {
            String? datetimeString = user['datetime'] as String?;
            DateTime? datetime;
            if (datetimeString != null) {
              try {
                datetime = DateTime.parse(datetimeString);
              } catch (e) {
                print('Error parsing datetime: $e');
              }
            }

            return UserProfile(
              name: user['name'] as String,
              password: user['password'] as String,
              age: user['age'] as int,
              height: user['height'] as double,
              weight: user['weight'] as double,
              lingkarKepala: user['lingkar_kepala'] as int,
              lingkarDada: user['lingkar_dada'] as int,
              admin: (user['admin'] as String?) == 'true',
              datetime: datetime!,
            );
          }).toList()
        : [];
    await db.close();
    return userProfiles;
  }

  Future<void> updateUserHeight(String name, double newHeight) async {
    final Database db = await openDB();
    await db.update(
      'user_profile',
      {'height': newHeight},
      where: 'name = ?',
      whereArgs: [name],
    );
    await db.close();
  }

  UserProfile fromMqttData(UserProfile user, Map<String, dynamic> data) {
    return UserProfile(
      name: data['name'] ?? user.name,
      password: data['password'] ?? user.password,
      age: data['age'] ?? user.age,
      height: data['height'] ?? user.height,
      weight: data['weight'] ?? user.weight,
      lingkarKepala: data['lingkarKepala'] ?? user.lingkarKepala,
      lingkarDada: data['lingkarDada'] ?? user.lingkarDada,
      admin: data['admin'] ?? user.admin,
      datetime: DateTime.parse(data['datetime']),
    );
  }

  Future<void> updateUserDataWithHighestId(UserProfile user) async {
    final Database db = await openDB();
    var result = await db.query(
      'user_profile',
      columns: ['MAX(id) as id'],
      where: 'name = ?',
      whereArgs: [user.name],
    );

    int? highestId = Sqflite.firstIntValue(result);

    if (highestId != null) {
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
        where: 'id = ?',
        whereArgs: [highestId],
      );
    }
    await db.close();
  }

  Future<UserProfile?> getUserByNameAndPassword(
      String name, String password) async {
    final Database db = await openDB();
    const String sql = '''
      SELECT * FROM user_profile 
      WHERE name = ? AND password = ? 
      ORDER BY id DESC
      LIMIT 1;
    ''';
    final List<Map<String, dynamic>> result =
        await db.rawQuery(sql, [name, password]);
    await db.close();
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

  Future<void> deleteDB() async {
    String path = await getPathDB();
    await deleteDatabase(path);
    print('deleted database at $path');
  }

  Future<List<String>> getTables() async {
    final Database db = await openDB();
    final List<Map<String, dynamic>> tables =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    await db.close();
    return tables.map((row) => row['name'] as String).toList();
  }

  Future<void> convertDbToExcel(String dbPath, String excelFilePath) async {
    final Database db = await openDatabase(dbPath);
    var excel = Excel.createExcel();

    List<String> tables = await getTables();

    for (String table in tables) {
      Sheet sheet = excel[table];
      List<Map<String, dynamic>> rows = await db.query(table);
      if (rows.isNotEmpty) {
        sheet.appendRow(
            rows.first.keys.map((key) => TextCellValue(key)).toList());
        for (var row in rows) {
          sheet.appendRow(row.values
              .map((value) => TextCellValue(value.toString()))
              .toList());
        }
      }
    }

    var fileBytes = excel.save();
    File(excelFilePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(fileBytes!);

    await db.close();
  }

  Future<void> downloadDB() async {
    try {
      String dbFilePath = await getPathDB();
      String downloadPath = '/storage/emulated/0/Download/stun_sync';
      Directory newDirectory = Directory(downloadPath);
      if (!await newDirectory.exists()) {
        await newDirectory.create(recursive: true);
      }
      String excelFilePath = join(newDirectory.path, 'stun_sync_data.xlsx');
      await convertDbToExcel(dbFilePath, excelFilePath);
    } on FileSystemException catch (e) {
      throw Exception('File system error: $e');
    } catch (e) {
      throw Exception('Error downloading database: $e');
    }
  }

  Future<void> parseMQTTData(Map<String, dynamic> mqttData) async {
    try {
      final Database db = await openDB();
      String currentDate =
          DateTime.now().toString().substring(0, 10).replaceAll('-', '_');
      bool tableExists = await isTableExists('user_profile_$currentDate');

      if (tableExists) {
        await db.rawUpdate(
          'UPDATE user_profile_$currentDate SET height = ?, weight = ?',
          [mqttData['height'], mqttData['weight']],
        );
        print('Updated height and weight for $currentDate');
      } else {
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

  Future<void> updateUserLingkarDada(String name, int newLingkarDada) async {
    try {
      final Database db = await openDB();
      String currentDate = DateTime.now().toIso8601String().substring(0, 10);

      final count = await db.update(
        'user_profile',
        {'lingkar_dada': newLingkarDada},
        where: 'name = ? AND datetime LIKE ?',
        whereArgs: [name, '$currentDate%'],
      );

      print('Rows affected: $count');
      await db.close();
    } catch (e) {
      print('Error during update: $e');
      throw e;
    }
  }

  Future<void> updateUserLingkarKepala(
      String name, int newLingkarKepala) async {
    try {
      final Database db = await openDB();
      String currentDate = DateTime.now().toIso8601String().substring(0, 10);

      final count = await db.update(
        'user_profile',
        {'lingkar_kepala': newLingkarKepala},
        where: 'name = ? AND datetime LIKE ?',
        whereArgs: [name, '$currentDate%'],
      );

      print('Rows affected: $count');
      await db.close();
    } catch (e) {
      print('Error during update: $e');
      throw e;
    }
  }
}
