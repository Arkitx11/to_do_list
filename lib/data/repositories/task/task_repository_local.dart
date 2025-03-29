import 'package:to_do_list/data/services/local/local_data_service.dart';

import '../../../domain/models/task/task.dart';

/// [TaskRepositoryLocal] provides functionality to insert, update, delete and fetch [Task] from local database

// This isn't a fucking repository, just a fucking wrapper serving no purpose but kept it for simplicity in the app

class TaskRepositoryLocal {
  TaskRepositoryLocal({required LocalDataService localDataService})
    : _localDataService = localDataService;
  final LocalDataService _localDataService;

  /// Fetches all [Task] entries from the database
  Future<List<Task>> getTasks() async {
    return await _localDataService.getTasks();
  }

  /// Inserts a [Task] entry into the database
  Future<void> insertTask(Task task) async {
    await _localDataService.insertTask(task);
  }

  /// Updates a [Task] entry in the database
  Future<void> updateTask(Task task) async {
    await _localDataService.updateTask(task);
  }

  /// Deletes a given [Task] entry fromthe database
  Future<void> deleteTask(Task task) async {
    await _localDataService.deleteTask(task.id!);
  }
}
