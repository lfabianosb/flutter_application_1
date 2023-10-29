import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_application_1/app_todo_bloc/application/save_task/save_task_cubit.dart';
import 'package:flutter_application_1/app_todo_bloc/application/save_task/save_task_state.dart';
import 'package:flutter_application_1/app_todo_bloc/domain/datasources/i_task_datasource.dart';
import 'package:flutter_application_1/app_todo_bloc/domain/model/task.dart';

class TaskDatasourceMock extends Mock implements ITaskDatasource {}

void main() {
  late ITaskDatasource taskDatasource;
  late Task task;

  setUp(() {
    taskDatasource = TaskDatasourceMock();
    task = Task.create(id: 'any_id', description: 'any_description');
    registerFallbackValue(task);
  });

  group('SaveTaskCubit', () {
    test('emits [InitialSaveTaskState] when created', () async {
      when(() => taskDatasource.save(any())).thenAnswer((_) => Future.value());
      final cubit = SaveTaskCubit(taskDatasource: taskDatasource);
      await cubit.execute(task.description);
      expect(SaveTaskCubit(taskDatasource: taskDatasource).state,
          InitialSaveTaskState());
    });

    blocTest<SaveTaskCubit, SaveTaskState>(
      'emits [ExecutingSaveTaskState, ExecutedSaveTaskState] when executed',
      setUp: () => when(() => taskDatasource.save(any()))
          .thenAnswer((_) => Future.value()),
      build: () => SaveTaskCubit(taskDatasource: taskDatasource),
      act: (cubit) async =>
          await cubit.execute(task.description, task.id.value),
      expect: () =>
          [ExecutingSaveTaskState(), ExecutedSaveTaskState(task: task)],
    );

    blocTest<SaveTaskCubit, SaveTaskState>(
      'emits [ExecutingSaveTaskState, ErrorSaveTaskState] when save method raises an error',
      setUp: () =>
          when(() => taskDatasource.save(any())).thenThrow(Exception()),
      build: () => SaveTaskCubit(taskDatasource: taskDatasource),
      act: (cubit) async => await cubit.execute(task.description),
      expect: () => [
        ExecutingSaveTaskState(),
        ErrorSaveTaskState(
            description: 'Erro ao savar a tarefa ${task.description}')
      ],
    );
  });
}
