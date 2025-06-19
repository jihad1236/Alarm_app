// ignore_for_file: depend_on_referenced_packages

import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class AlarmController extends GetxController {
  final alarms = <Map<String, dynamic>>[].obs;
  Database? _db;

  @override
  void onInit() {
    super.onInit();
    _initDatabase();
  }

  /// Initialize SQLite Database
  Future<void> _initDatabase() async {
    final docDir = await getApplicationDocumentsDirectory();
    final dbPath = join(docDir.path, 'alarm.db');

    _db = await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE alarms (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            time TEXT NOT NULL,
            date TEXT NOT NULL,
            enabled INTEGER NOT NULL
          )
        ''');
      },
    );

    await loadAlarms();
  }

  /// Load all alarms from DB
  Future<void> loadAlarms() async {
    if (_db == null) return;
    final data = await _db!.query('alarms', orderBy: 'id DESC');
    alarms.assignAll(data);
  }

  /// Add a new alarm
  Future<void> addAlarm(String time, String date) async {
    if (_db == null) return;

    final id = await _db!.insert('alarms', {
      'time': time,
      'date': date,
      'enabled': 1,
    });

    alarms.insert(0, {'id': id, 'time': time, 'date': date, 'enabled': 1});
  }

  /// Toggle ON/OFF alarm
  Future<void> toggleAlarm(int id, bool enabled) async {
    if (_db == null) return;

    await _db!.update(
      'alarms',
      {'enabled': enabled ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );

    await loadAlarms();
  }

  /// Delete alarm by ID
  Future<void> deleteAlarm(int id) async {
    if (_db == null) return;

    await _db!.delete('alarms', where: 'id = ?', whereArgs: [id]);

    await loadAlarms();
  }
}
