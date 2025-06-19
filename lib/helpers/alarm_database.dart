import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class AlarmDB {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'alarm.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE IF NOT EXISTS alarms (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            time TEXT NOT NULL,
            date TEXT NOT NULL,
            enabled INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  static Future<int> insertAlarm(String time, String date) async {
    final db = await database;
    return await db.insert('alarms', {
      'time': time,
      'date': date,
      'enabled': 1,
    });
  }

  static Future<List<Map<String, dynamic>>> getAlarms() async {
    final db = await database;
    return await db.query('alarms', orderBy: 'id DESC');
  }

  static Future<int> toggleAlarm(int id, bool enabled) async {
    final db = await database;
    return await db.update(
      'alarms',
      {'enabled': enabled ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> deleteAlarm(int id) async {
    final db = await database;
    return await db.delete('alarms', where: 'id = ?', whereArgs: [id]);
  }
}
