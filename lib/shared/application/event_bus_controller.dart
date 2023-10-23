import 'package:flutter_application_1/app_todo/domain/events/task_saved_event.dart';
import 'package:flutter_application_1/app_todo/domain/events/task_saved_event_handler.dart';
import 'package:flutter_application_1/cep/common/events/events.dart';
import 'package:flutter_application_1/shared/domain/events/events.dart';

class EventBusController {
  final IEventBus eventBus;
  final CepSalvedOnLocalDsEventHandler cepSalvedOnLocalDsEventHandler;
  final TaskSavedEventHandler taskSavedEventHandler;

  EventBusController({
    required this.cepSalvedOnLocalDsEventHandler,
    required this.taskSavedEventHandler,
    required this.eventBus,
  });

  void init() {
    eventBus.on<CepSalvedOnLocalDsEvent>().listen((event) {
      cepSalvedOnLocalDsEventHandler.handle(event);
    });
    eventBus.on<TaskSavedEvent>().listen((event) {
      taskSavedEventHandler.handle(event);
    });
  }
}
