import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_application_1/app_todo_bloc/application/list_all_tasks/list_all_tasks_cubit.dart';
import 'package:flutter_application_1/app_todo_bloc/application/list_all_tasks/list_all_tasks_state.dart';
import 'package:flutter_application_1/app_todo_bloc/application/save_task/save_task_state.dart';
import 'package:flutter_application_1/app_todo_bloc/domain/datasources/i_task_datasource.dart';
import 'package:flutter_application_1/app_todo_bloc/domain/model/task.dart';

class TaskDatasourceMock extends Mock implements ITaskDatasource {}

void main() {
  late ITaskDatasource taskDatasource;
  late StreamController streamController;

  setUp(() {
    taskDatasource = TaskDatasourceMock();
    streamController = StreamController.broadcast();
  });

  group('ListAllTasksCubit', () {
    test('emits [InitialListAllTasksState] when created', () {
      expect(
          ListAllTasksCubit(
                  taskDatasource: taskDatasource,
                  streamSaveTask: streamController.stream)
              .state,
          InitialListAllTasksState());
    });

    blocTest<ListAllTasksCubit, ListAllTasksState>(
      'emits [ExecutingListAllTasksState, ExecutedListAllTasksState] when executed',
      setUp: () => when(() => taskDatasource.findAll())
          .thenAnswer((_) => Future.value([])),
      build: () => ListAllTasksCubit(
          taskDatasource: taskDatasource,
          streamSaveTask: streamController.stream),
      act: (cubit) async => await cubit.execute(),
      expect: () => [
        ExecutingListAllTasksState(),
        ExecutedListAllTasksState(tasks: const [])
      ],
    );

    blocTest<ListAllTasksCubit, ListAllTasksState>(
      'emits [ExecutingListAllTasksState, ErrorListAllTasksState] when executed with error',
      setUp: () => when(() => taskDatasource.findAll()).thenThrow(Exception()),
      build: () => ListAllTasksCubit(
          taskDatasource: taskDatasource,
          streamSaveTask: streamController.stream),
      act: (cubit) async => await cubit.execute(),
      expect: () => [
        ExecutingListAllTasksState(),
        ErrorListAllTasksState(description: 'Erro ao listar as tarefas')
      ],
    );

    blocTest<ListAllTasksCubit, ListAllTasksState>(
      'emits [ExecutingListAllTasksState, ExecutedListAllTasksState] when ExecutedSaveTaskState is emitted',
      setUp: () => when(() => taskDatasource.findAll())
          .thenAnswer((_) => Future.value([])),
      build: () => ListAllTasksCubit(
          taskDatasource: taskDatasource,
          streamSaveTask: streamController.stream),
      act: (_) => streamController.add(
          ExecutedSaveTaskState(task: Task.create(description: 'description'))),
      expect: () => [
        ExecutingListAllTasksState(),
        ExecutedListAllTasksState(tasks: const [])
      ],
    );
  });
}
