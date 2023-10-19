import 'package:flutter_application_1/shared/domain/events/events.dart';

abstract interface class IDomainEventHandler {
  Future<void> handle(IDomainEvent domainEvent);
}
