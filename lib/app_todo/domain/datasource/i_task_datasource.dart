import 'package:flutter_application_1/app_todo/domain/model/task.dart';

abstract interface class ITaskDatasource {
  Future<void> save(Task task);
}
