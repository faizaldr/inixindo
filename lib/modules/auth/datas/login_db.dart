import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LoginDb {
  static Database? _database;

  Future<Database> get database async {
    // ketika aplikasi sudah pernah dijalankan
    if (_database != null) return _database!;
    // ketika aplikasi pertama kali dijalankan
    _database = await _initDB();
    return _database!;
  }

  Future<Database?> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "param.db");
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String sql =
            "CREATE TABLE param (id INTEGER PRIMARY KEY AUTOINCREMENT, key TEXT, value TEXT)";
        await db.execute(sql);
        String sql2 = "INSERT INTO param(id, key) VALUES(1,'token')";
        await db.execute(sql2);
      },
    );
  }

  Future<int> saveToken(String token) async {
    final db = await database;
    return await db.update("param", {'value': token}, where: "id=?", whereArgs: [1]);
  }

  Future<String?> getToken() async {
    final db = await database;
    final result = await db.query("param", columns: ['value'], where: "id=?", whereArgs: [1], limit: 1);
    if(result.isNotEmpty){
      return result.first['value'] as String;
    }
    return null;
  }

  Future<int> removeToken(String token) async {
    final db = await database;
    return await db.update("param", {'value': null}, where: "id=?", whereArgs: [1]);
  }
}
