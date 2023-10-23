import 'package:flutter_application_1/app_todo/list_tasks/list_tasks_store.dart';
import 'package:flutter_application_1/shared/domain/events/events.dart';
import 'package:flutter_application_1/shared/domain/events/handlers/handlers.dart';

class TaskSavedEventHandler implements IDomainEventHandler {
  final ListTasksStore listTasksStore;

  TaskSavedEventHandler({required this.listTasksStore});

  @override
  Future<void> handle(IDomainEvent domainEvent) async {
    listTasksStore.execute();
  }
}
