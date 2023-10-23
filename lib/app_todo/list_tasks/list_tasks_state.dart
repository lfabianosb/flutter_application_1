import 'package:equatable/equatable.dart';

import 'package:flutter_application_1/app_todo/domain/model/task.dart';

sealed class ListTasksState extends Equatable {}

class InitialListTasksState extends ListTasksState {
  @override
  List<Object?> get props => [];
}

class ExecutingListTasksState extends ListTasksState {
  @override
  List<Object?> get props => [];
}

class ExecutedListTasksState extends ListTasksState {
  final List<Task> tasks;

  ExecutedListTasksState({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

class ErrorListTasksState extends ListTasksState {
  final String? description;

  ErrorListTasksState({this.description});

  @override
  List<Object?> get props => [description];
}
