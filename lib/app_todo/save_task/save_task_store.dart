import 'package:flutter/material.dart';

import 'package:flutter_application_1/app_todo/domain/datasources/i_task_datasource.dart';
import 'package:flutter_application_1/app_todo/domain/events/task_saved_event.dart';
import 'package:flutter_application_1/app_todo/domain/model/task.dart';
import 'package:flutter_application_1/app_todo/save_task/save_task_state.dart';
import 'package:flutter_application_1/shared/domain/events/events.dart';

class SaveTaskStore extends ChangeNotifier {
  SaveTaskState _state = InitialSaveTaskState();
  final ITaskDatasource taskDatasource;
  final IEventBus eventBus;

  SaveTaskStore({
    required this.taskDatasource,
    required this.eventBus,
  });

  SaveTaskState get state => _state;

  Future<void> execute(String description) async {
    _state = ExecutingSaveTaskState();
    notifyListeners();
    try {
      final task = Task.create(description: description);
      await taskDatasource.save(task);
      eventBus.fire(TaskSavedEvent(task: task));
      _state = ExecutedSaveTaskState(task: task);
    } on Exception {
      _state = ErrorSaveTaskState(
          description: 'Erro ao salvar a tarefa $description');
    }
    notifyListeners();
  }
}
