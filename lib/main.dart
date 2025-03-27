import 'package:flutter/material.dart';
import 'package:to_do_list/data/repositories/task/task_repository_local.dart';
import 'package:to_do_list/data/services/local/local_data_service.dart';
import 'package:to_do_list/data/services/local/local_database_provider.dart';

import 'domain/models/task/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final taskRepo = TaskRepositoryLocal(
    localDataService: LocalDataService(
      await LocalDatabaseProvider().database,
    ),
  );
  await taskRepo.insertTask(
    Task(
      id: 1,
      title: 'test',
      description: 'hello',
      timestamp: DateTime.now().toString(),
    ),
  );
  final tasks = await taskRepo.getTasks();
  for (final task in tasks) {
    print(task.toString());
  }
}
