import 'package:flutter_application_1/cep/consultar_historico/consultar_historico.dart';
import 'package:flutter_application_1/shared/domain/events/events.dart';
import 'package:flutter_application_1/shared/domain/events/handlers/handlers.dart';

class CepSalvedOnLocalDsEventHandler implements IDomainEventHandler {
  final ConsultarHistoricoCepStore consultarHistoricoCepStore;

  CepSalvedOnLocalDsEventHandler({required this.consultarHistoricoCepStore});

  @override
  Future<void> handle(IDomainEvent domainEvent) async {
    await consultarHistoricoCepStore.consultar();
  }
}
