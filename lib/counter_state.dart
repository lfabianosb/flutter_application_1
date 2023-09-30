import 'package:equatable/equatable.dart';

sealed class CounterState extends Equatable {
  final int value;

  const CounterState({this.value = 0});
}

class SuccessCounterState extends CounterState {
  const SuccessCounterState({super.value});
  
  @override
  List<Object?> get props => [value];
}

class ErrorCounterState extends CounterState {
  final String? description;

  const ErrorCounterState({this.description});

  @override
  List<Object?> get props => [value, description];
}

class LoadingCounterState extends CounterState {
  @override
  List<Object?> get props => [value];
}