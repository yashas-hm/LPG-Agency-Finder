import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static const String database = 'AgencyData';

  static Future<sql.Database> getDatabase() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'database.db'),
        onCreate: (db, version) {
      db.rawQuery(
          "CREATE TABLE $database(id TEXT PRIMARY KEY, name TEXT, contact TEXT, cost INTEGER, address TEXT)");
    }, version: 1);
  }

  static Future<void> addAgency(Map<String, dynamic> map) async {
    final sqlDB = await getDatabase();
    await sqlDB.insert(
      database,
      map,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getList() async{
    final sqlDB = await getDatabase();
    return sqlDB.query(database);
  }
}
