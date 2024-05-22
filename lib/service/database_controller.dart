import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/utils/utils.dart';
import 'package:stun_sync/models/user_profile.dart';

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
          admin TEXT
        )
      ''');
    });
    return database;
  }

  Future<void> showTables(Database db) async {
    List<Map<String, dynamic>> tables = await db.rawQuery(
      'SELECT name FROM sqlite_master WHERE type = "table"',
    );

    tables.forEach((element) {
      print(element);
    });
  }

  Future<void> showAllUsers(Database db) async {
    List<Map<String, dynamic>> users = await db.query('user_profile');

    users.forEach((user) {
      print(user);
    });
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

  Future<bool> searchUser(Database db, String name, String password) async {
    final List<Map<String, dynamic>> maps = await db.query(
      'user_profile',
      where: 'name = ? AND password = ?',
      whereArgs: [name, password],
    );

    return maps.isNotEmpty;
  }

  Future<void> closeDB(Database db) async {
    await db.close();
  }

  Future<void> deleteDB() async {
    String path = await getPathDB();
    await deleteDatabase(path);
  }
}
