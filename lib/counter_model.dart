import 'package:flutter/material.dart';
import 'package:flutter_application_1/counter_state.dart';

class CounterModel extends ChangeNotifier {
  CounterState _state = SuccessCounterState();

  CounterState get state => _state;

  void increment() {
    if (_state is SuccessCounterState) {
      _state = SuccessCounterState(value: _state.value + 1);
    } else {
      _state = SuccessCounterState();
    }
    notifyListeners();
  }

  void decrement() {
    if (_state is SuccessCounterState) {
      if (_state.value > 0) {
        _state = SuccessCounterState(value: _state.value - 1);
      } else {
        _state = ErrorCounterState(description: 'Numero negativo não permitido');
      }
    }
    notifyListeners();
  }
}