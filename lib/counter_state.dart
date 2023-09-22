sealed class CounterState {
  final int value;

  CounterState({this.value = 0});
}

class SuccessCounterState extends CounterState {
  SuccessCounterState({super.value});
}

class ErrorCounterState extends CounterState {
  final String? description;

  ErrorCounterState({this.description});
}