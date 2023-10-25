import 'package:flutter/material.dart';

import 'package:flutter_application_1/app_todo/application/list_tasks/list_tasks_state.dart';
import 'package:flutter_application_1/app_todo/domain/datasources/i_task_datasource.dart';

class ListTasksStore extends ChangeNotifier {
  ListTasksState _state = InitialListTasksState();
  final ITaskDatasource taskDatasource;

  ListTasksStore({
    required this.taskDatasource,
  });

  ListTasksState get state => _state;

  Future<void> execute() async {
    debugPrint('ListTasksStore.execute()');
    _state = ExecutingListTasksState();
    notifyListeners();
    try {
      final tasks = await taskDatasource.findAll();
      _state = ExecutedListTasksState(tasks: tasks);
    } on Exception {
      _state = ErrorListTasksState(description: 'Erro ao listas as tarefas');
    }
    notifyListeners();
  }
}
