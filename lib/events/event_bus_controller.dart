import 'package:flutter_application_1/events/events.dart';
import 'package:flutter_application_1/events/handlers/handlers.dart';

class EventBusController {
  final EventBus eventBus;
  final CepSalvedOnLocalDsEventHandler cepSalvedOnLocalDsEventHandler;

  EventBusController({
    required this.cepSalvedOnLocalDsEventHandler,
    required this.eventBus,
  });

  void init() {
    eventBus.on<CepSalvedOnLocalDsEvent>().listen((event) {
      cepSalvedOnLocalDsEventHandler.handle(event);
    });
  }
}
