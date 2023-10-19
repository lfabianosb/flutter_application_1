import 'package:flutter_application_1/shared/domain/events/events.dart';

class CepSalvedOnLocalDsEvent implements IDomainEvent {
  final String cep;

  CepSalvedOnLocalDsEvent({required this.cep});
}
