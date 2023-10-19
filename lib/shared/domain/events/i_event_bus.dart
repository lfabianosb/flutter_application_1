import 'package:flutter_application_1/shared/domain/events/events.dart';

abstract interface class IEventBus {
  Stream<T> on<T>();
  void fire(IDomainEvent event);
  void destroy();
}
