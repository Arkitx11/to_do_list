import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

/// [LocalDatabaseProvider] is reponsbile for establishing a connection to the sqflite package
/// Singelton Pattern has been followed to avoid multiple instanitation


// TODO: Figure out whether I really do need a fucking singleton pattern or not?
//       Even though Dart is a single threaded language and I intend to use DI



class LocalDatabaseProvider {
  static const _databaseName = 'task_database.db';
  static const _databaseVersion = 1;

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }


  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        id INTEGER PRIMARY KEY,
        title TEXT NOT NULL,
        description TEXT,
        timestamp TEXT NOT NULL,
        status TEXT CHECK(status IN ('pending', 'completed')) NOT NULL DEFAULT 'pending'
      )
    ''');
  }

  Future<Database> _initDatabase() async {
    try {
      return openDatabase(
        join(await getDatabasesPath(), _databaseName),
        onCreate: _onCreate,
        version: _databaseVersion,
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint(e.toString());
        debugPrintStack(stackTrace: stackTrace);
      } else {
        final logger = Logger();
        logger.d(e, stackTrace: stackTrace);
      }
      rethrow;
    }
  }
}
