// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:flutter_application_1/todo/stream/domain/model/task.dart';

sealed class ListAllTasksState extends Equatable {}

class InitialListAllTasksState extends ListAllTasksState {
  @override
  List<Object?> get props => [];
}

class ExecutingListAllTasksState extends ListAllTasksState {
  @override
  List<Object?> get props => [];
}

class ExecutedListAllTasksState extends ListAllTasksState {
  final List<Task> tasks;

  ExecutedListAllTasksState({required this.tasks});

  @override
  List<Object?> get props => [tasks];
}

class ErrorListAllTasksState extends ListAllTasksState {
  final String? description;

  ErrorListAllTasksState({this.description});

  @override
  List<Object?> get props => [description];
}
