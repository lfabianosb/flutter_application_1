import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/app_todo_bloc/application/list_all_tasks/list_all_tasks_state.dart';
import 'package:flutter_application_1/app_todo_bloc/application/save_task/save_task_state.dart';
import 'package:flutter_application_1/app_todo_bloc/domain/datasources/i_task_datasource.dart';

class ListAllTasksCubit extends Cubit<ListAllTasksState> {
  final ITaskDatasource taskDatasource;
  final Stream streamSaveTask;

  ListAllTasksCubit({
    required this.taskDatasource,
    required this.streamSaveTask,
  }) : super(InitialListAllTasksState()) {
    streamSaveTask.listen((state) {
      if (state is ExecutedSaveTaskState) {
        execute();
      }
    });
  }

  Future<void> execute() async {
    debugPrint('ListAllTasksStore.execute()');
    emit(ExecutingListAllTasksState());
    try {
      final tasks = await taskDatasource.findAll();
      emit(ExecutedListAllTasksState(tasks: tasks));
    } on Exception {
      emit(ErrorListAllTasksState(description: 'Erro ao listar as tarefas'));
    }
  }
}
