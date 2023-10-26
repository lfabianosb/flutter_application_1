import 'package:flutter_application_1/app_todo_bloc/domain/model/task.dart';
import 'package:flutter_application_1/shared/domain/vo/id.dart';

abstract interface class ITaskDatasource {
  Future<void> save(Task task);
  Future<List<Task>> remove(Id id);
  Future<List<Task>> findAll();
}
