import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/todo/stream/application/save_task/save_task_state.dart';
import 'package:flutter_application_1/todo/stream/domain/model/task.dart';
import 'package:flutter_application_1/todo/stream/domain/repository/i_task_repository.dart';

class SaveTaskCubit extends Cubit<SaveTaskState> {
  final ITaskRepository _repository;

  SaveTaskCubit({
    required ITaskRepository repository,
  })  : _repository = repository,
        super(InitialSaveTaskState());

  Future<void> execute(String description, [String? id]) async {
    emit(ExecutingSaveTaskState());
    try {
      if (description == 'a') {
        throw Exception();
      }
      final task = Task.create(id: id, description: description);
      await _repository.save(task);
      emit(ExecutedSaveTaskState(task: task));
    } on Exception {
      emit(ErrorSaveTaskState(
          description: 'Erro ao savar a tarefa $description'));
    }
  }
}
