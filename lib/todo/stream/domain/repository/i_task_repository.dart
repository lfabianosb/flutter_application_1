import 'package:flutter_application_1/todo/stream/domain/model/task.dart';

abstract interface class ITaskRepository {
  Future<void> save(Task task);
  Future<void> remove(TaskId id);
  Stream<List<Task>> findAll();
}
