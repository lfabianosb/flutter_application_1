import 'package:flutter_application_1/cep/consultar_historico/consultar_historico.dart';
import 'package:flutter_application_1/events/events.dart';
import 'package:flutter_application_1/events/handlers/handlers.dart';

class CepSalvedOnLocalDsEventHandler implements DomainEventHadler {
  final ConsultarHistoricoCepStore consultarHistoricoCepStore;

  CepSalvedOnLocalDsEventHandler({required this.consultarHistoricoCepStore});

  @override
  Future<void> handle(DomainEvent domainEvent) async {
    await consultarHistoricoCepStore.consultar();
  }
}
