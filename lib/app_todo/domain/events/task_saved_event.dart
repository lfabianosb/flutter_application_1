import 'package:flutter_application_1/app_todo/domain/model/task.dart';
import 'package:flutter_application_1/shared/domain/events/events.dart';

class TaskSavedEvent implements IDomainEvent {
  final Task task;

  TaskSavedEvent({required this.task});
}
