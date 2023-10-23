import 'package:flutter_application_1/shared/domain/events/events.dart';

abstract interface class IDomainEventHandler<T extends IDomainEvent> {
  Future<void> handle(T event);
}
