import 'package:flutter_application_1/cep/common/events/events.dart';
import 'package:flutter_application_1/shared/infra/event_bus.dart';

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
