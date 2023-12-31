import 'dart:async';

import 'package:flutter_application_1/shared/domain/events/events.dart';

class EventBus implements IEventBus {
  final StreamController _streamController;

  /// Controller for the event bus stream.
  StreamController get streamController => _streamController;

  /// Creates an [EventBus].
  ///
  /// If [sync] is true, events are passed directly to the stream's listeners
  /// during a [fire] call. If false (the default), the event will be passed to
  /// the listeners at a later time, after the code creating the event has
  /// completed.
  EventBus({bool sync = false})
      : _streamController = StreamController.broadcast(sync: sync);

  /// Listens for events of Type [T] and its subtypes.
  ///
  /// The method is called like this: myEventBus.on<MyType>();
  ///
  /// If the method is called without a type parameter, the [Stream] contains every
  /// event of this [EventBus].
  ///
  /// The returned [Stream] is a broadcast stream so multiple subscriptions are
  /// allowed.
  ///
  /// Each listener is handled independently, and if they pause, only the pausing
  /// listener is affected. A paused listener will buffer events internally until
  /// unpaused or canceled. So it's usually better to just cancel and later
  /// subscribe again (avoids memory leak).
  ///
  @override
  Stream<T> on<T>() {
    if (T == dynamic) {
      return _streamController.stream as Stream<T>;
    } else {
      return _streamController.stream.where((event) => event is T).cast<T>();
    }
  }

  /// Fires a new event on the event bus with the specified [event].
  ///
  @override
  void fire(IDomainEvent event) {
    _streamController.add(event);
  }

  /// Destroy this [EventBus]. This is generally only in a testing context.
  ///
  @override
  void destroy() {
    _streamController.close();
  }
}
