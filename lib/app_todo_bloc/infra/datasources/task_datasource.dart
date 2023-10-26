import 'package:flutter_application_1/app_todo_bloc/domain/datasources/i_task_datasource.dart';
import 'package:flutter_application_1/app_todo_bloc/domain/model/task.dart';
import 'package:flutter_application_1/shared/domain/vo/id.dart';

class TaskDatasource implements ITaskDatasource {
  final List<Task> tasks = [Task.create(description: 'teste')];

  @override
  Future<void> save(Task task) async {
    tasks.add(task);
  }

  @override
  Future<List<Task>> findAll() async {
    return tasks;
  }

  @override
  Future<List<Task>> remove(Id id) async {
    return tasks.where((task) => task.id.value != id.value).toList();
  }
}
