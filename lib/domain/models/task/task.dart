import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sqflite/sqflite.dart';

part 'task.freezed.dart';

part 'task.g.dart';

/// Represents a task entity in the application
/// ### Key Consideration
/// [timestamp] is stored as String because [Sqflite] doesn't natively support [DateTime] storage in database.
/// Use [DateTime.now().toIso8601String()] to store the current time


// Freezed package was used to ensure immutability and some hipster stuff of toString()
// and more importantly as best practise
@freezed
abstract class Task with _$Task {
  const factory Task({
    required int id,
    required String title,
    required String description,
    required String timestamp,

    @Default('pending') String status,
  }) = _Task;

  /// Convert JSON to Task object
  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}
