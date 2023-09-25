import 'package:flutter/material.dart';
import 'package:flutter_application_1/counter_state.dart';

class CounterStore extends ChangeNotifier {
  CounterState _state = SuccessCounterState();

  CounterState get state => _state;

  void increment() async {
    if (_state is SuccessCounterState) {
      int value = _state.value;
      _state = LoadingCounterState();
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 500));
      _state = SuccessCounterState(value: value + 1);
    } else {
      _state = SuccessCounterState();
    }
    notifyListeners();
  }

  void decrement() async {
    if (_state is SuccessCounterState) {
      if (_state.value > 0) {
        int value = _state.value;
        _state = LoadingCounterState();
        notifyListeners();
        await Future.delayed(const Duration(milliseconds: 500));
        _state = SuccessCounterState(value: value - 1);
      } else {
        _state = ErrorCounterState(description: 'Numero negativo não permitido');
      }
    }
    notifyListeners();
  }
}