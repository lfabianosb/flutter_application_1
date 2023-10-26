import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

import 'package:flutter_application_1/app_todo_bloc/application/list_all_tasks/list_all_tasks_state.dart';
import 'package:flutter_application_1/app_todo_bloc/domain/datasources/i_task_datasource.dart';

class ListAllTasksCubit extends Cubit<ListAllTasksState> {
  final ITaskDatasource taskDatasource;

  ListAllTasksCubit({
    required this.taskDatasource,
  }) : super(InitialListAllTasksState());

  Future<void> execute() async {
    debugPrint('ListAllTasksStore.execute()');
    emit(ExecutingListAllTasksState());
    try {
      final tasks = await taskDatasource.findAll();
      emit(ExecutedListAllTasksState(tasks: tasks));
    } on Exception {
      emit(ErrorListAllTasksState(description: 'Erro ao listas as tarefas'));
    }
  }
}
