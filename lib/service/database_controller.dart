import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stun_sync/models/user_profile.dart';

class SQLiteDB {
  const SQLiteDB();

  Future<String> getPathDB() async {
    String path = await getDatabasesPath();
    return join(path, 'stun_sync.db');
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

  Future<void> showUserProfileTable() async {
    final Database db = await openDB();
    List<Map<String, dynamic>> userProfiles = await db.query('user_profile');
    for (var userProfile in userProfiles) {
      print(userProfile);
    }
    await db.close();
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

  Future<bool> userIsExist(String name, String password, bool admin) async {
    final Database db = await openDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'user_profile',
      where: 'name = ? AND password = ? AND admin = ?',
      whereArgs: [name, password, admin.toString()],
    );
    await db.close();
    return maps.isNotEmpty;
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
