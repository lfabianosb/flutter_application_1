import 'package:flutter_application_1/events/events.dart';

class CepSalvedOnLocalDsEvent implements DomainEvent {
  final String cep;

  CepSalvedOnLocalDsEvent({required this.cep});
}
