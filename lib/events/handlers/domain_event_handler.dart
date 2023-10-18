import 'package:flutter_application_1/events/events.dart';

abstract class DomainEventHadler {
  Future<void> handle(DomainEvent domainEvent);
}
