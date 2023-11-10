import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/todo/stream/application/list_all_tasks/list_all_tasks_state.dart';
import 'package:flutter_application_1/todo/stream/domain/repository/i_task_repository.dart';

class ListAllTasksCubit extends Cubit<ListAllTasksState> {
  final ITaskRepository _repository;

  ListAllTasksCubit({
    required ITaskRepository repository,
  })  : _repository = repository,
        super(InitialListAllTasksState());

  Future<void> execute() async {
    emit(ExecutingListAllTasksState());
    try {
      final streamOfTasks = _repository.findAll();
      streamOfTasks.listen(
        (tasks) => emit(ExecutedListAllTasksState(tasks: [...tasks])),
        onError: (_) => emit(
            ErrorListAllTasksState(description: 'Erro ao listar as tarefas')),
      );
    } on Exception {
      emit(ErrorListAllTasksState(description: 'Erro ao listar as tarefas'));
    }
  }
}
