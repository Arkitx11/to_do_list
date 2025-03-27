import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/models/task/task.dart';

/// [LocalDataService] contains the buisness logic for creating CRUD operations on database

class LocalDataService {
  final Database database;
  final Logger logger = Logger();

  LocalDataService(this.database);

  /// Inserts a [Task] into the database.
  Future<void> insertTask(Task task) async {
    try {
      await database.insert(
        'tasks',
        task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('Error inserting task: $e');
        debugPrintStack(stackTrace: stackTrace);
      } else {
        logger.e('Error inserting task', error: e, stackTrace: stackTrace);
      }
      rethrow;
    }
  }

  /// Fetches all the entries from the database.
  Future<List<Task>> getTasks() async {
    try {
      final List<Map<String, Object?>> taskMaps = await database.query('tasks');
      return [
        for (final {
        'id': id as int,
        'title': title as String,
        'description': description as String,
        'timestamp': timestamp as String,
        'status': status as String,
        } in taskMaps)
          Task(
            id: id,
            title: title,
            description: description,
            timestamp: timestamp,
            status: status,
          ),
      ];
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('Error fetching tasks: $e');
        debugPrintStack(stackTrace: stackTrace);
      } else {
        logger.e('Error fetching tasks', error: e, stackTrace: stackTrace);
      }
      rethrow;
    }
  }

  /// Updates a [Task] entry in the database
  Future<void> updateTask(Task task) async {
    try {
      await database.update(
        'tasks',
        task.toJson(),
        where: 'id = ?',
        whereArgs: [task.id],
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('Error updating task: $e');
        debugPrintStack(stackTrace: stackTrace);
      } else {
        logger.e('Error updating task', error: e, stackTrace: stackTrace);
      }
      rethrow;
    }
  }

  /// Deletes a [Task] from the database
  Future<void> deleteTask(int id) async {
    try {
      await database.delete(
        'tasks',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e, stackTrace) {
      if (kDebugMode) {
        debugPrint('Error deleting task: $e');
        debugPrintStack(stackTrace: stackTrace);
      } else {
        logger.e('Error deleting task', error: e, stackTrace: stackTrace);
      }
      rethrow;
    }
  }
}
