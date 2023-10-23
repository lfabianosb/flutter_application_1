import 'package:flutter_application_1/app_todo/application/list_tasks/list_tasks_store.dart';
import 'package:flutter_application_1/app_todo/domain/events/task_saved_event.dart';
import 'package:flutter_application_1/shared/domain/events/handlers/handlers.dart';

class TaskSavedEventHandler implements IDomainEventHandler<TaskSavedEvent> {
  final ListTasksStore listTasksStore;

  TaskSavedEventHandler({required this.listTasksStore});

  @override
  Future<void> handle(TaskSavedEvent event) async {
    listTasksStore.execute();
  }
}
