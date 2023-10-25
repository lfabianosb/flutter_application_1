import 'package:flutter_application_1/app_todo/domain/datasources/i_task_datasource.dart';
import 'package:flutter_application_1/app_todo/domain/model/task.dart';
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
  Future<List<Task>> findAllNotFinished() async {
    return tasks.where((task) => task.finishedAt == null).toList();
  }

  @override
  Future<List<Task>> findAllFinished() async {
    return tasks.where((task) => task.finishedAt != null).toList();
  }

  @override
  Future<List<Task>> remove(Id id) async {
    return tasks.where((task) => task.id.value != id.value).toList();
  }
}
