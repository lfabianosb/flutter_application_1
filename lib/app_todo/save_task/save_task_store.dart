import 'package:flutter/material.dart';

import 'package:flutter_application_1/app_todo/domain/datasource/i_task_datasource.dart';
import 'package:flutter_application_1/app_todo/domain/model/task.dart';
import 'package:flutter_application_1/app_todo/save_task/save_task_state.dart';

class SaveTaskStore extends ChangeNotifier {
  SaveTaskState _state = InitialSaveTaskState();
  final ITaskDatasource taskDatasource;

  SaveTaskStore({
    required this.taskDatasource,
  });

  SaveTaskState get state => _state;

  Future<void> execute(String description) async {
    _state = ExecutingSaveTaskState();
    notifyListeners();
    try {
      final task = Task.create(description: description);
      await taskDatasource.save(task);
      _state = ExecutedSaveTaskState(task: task);
    } on Exception {
      _state = ErrorSaveTaskState(
          description: 'Erro ao salvar a tarefa $description');
    }
    notifyListeners();
  }
}
