import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/app_todo_bloc/application/save_task/save_task_state.dart';
import 'package:flutter_application_1/app_todo_bloc/domain/datasources/i_task_datasource.dart';
import 'package:flutter_application_1/app_todo_bloc/domain/model/task.dart';

class SaveTaskCubit extends Cubit<SaveTaskState> {
  final ITaskDatasource taskDatasource;

  SaveTaskCubit({
    required this.taskDatasource,
  }) : super(InitialSaveTaskState());

  Future<void> execute(String description, [String? id]) async {
    emit(ExecutingSaveTaskState());
    try {
      if (description == 'a') {
        throw Exception();
      }
      final task = Task.create(id: id, description: description);
      await taskDatasource.save(task);
      emit(ExecutedSaveTaskState(task: task));
    } on Exception {
      emit(ErrorSaveTaskState(
          description: 'Erro ao savar a tarefa $description'));
    }
  }
}
