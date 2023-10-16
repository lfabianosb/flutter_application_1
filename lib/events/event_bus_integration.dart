import 'package:flutter_application_1/cep/consultar_historico/consultar_historico_cep_store.dart';
import 'package:flutter_application_1/events/events.dart';

class EventBusIntegration {
  final EventBus eventBus;
  final ConsultarHistoricoCepStore consultarHistoricoCepStore;

  EventBusIntegration({
    required this.consultarHistoricoCepStore,
    required this.eventBus,
  });

  void init() {
    eventBus.on<CepSalvedOnLocalDsEvent>().listen((event) {
      consultarHistoricoCepStore.consultar();
    });
  }
}
