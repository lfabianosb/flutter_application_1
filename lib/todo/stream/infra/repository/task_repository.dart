import 'dart:async';

import 'package:rxdart/rxdart.dart';

import 'package:flutter_application_1/todo/stream/domain/model/task.dart';
import 'package:flutter_application_1/todo/stream/domain/repository/i_task_repository.dart';

class TaskRepository implements ITaskRepository {
  final List<Task> tasks = [Task.create(description: 'teste')];
  final _controller =
      BehaviorSubject<List<Task>>.seeded([Task.create(description: 'teste')]);

  @override
  Stream<List<Task>> findAll() {
    return _controller.asBroadcastStream();
  }

  @override
  Future<void> remove(TaskId id) async {
    tasks.removeWhere((task) => task.id.value != id.value);
    _controller.add(tasks);
  }

  @override
  Future<void> save(Task task) async {
    tasks.add(task);
    _controller.add(tasks);
  }
}
