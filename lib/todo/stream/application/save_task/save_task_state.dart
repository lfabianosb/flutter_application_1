import 'package:equatable/equatable.dart';

import 'package:flutter_application_1/todo/stream/domain/model/task.dart';

sealed class SaveTaskState extends Equatable {}

class InitialSaveTaskState extends SaveTaskState {
  @override
  List<Object?> get props => [];
}

class ExecutingSaveTaskState extends SaveTaskState {
  @override
  List<Object?> get props => [];
}

class ExecutedSaveTaskState extends SaveTaskState {
  final Task task;

  ExecutedSaveTaskState({required this.task});

  @override
  List<Object?> get props => [task];
}

class ErrorSaveTaskState extends SaveTaskState {
  final String? description;

  ErrorSaveTaskState({this.description});

  @override
  List<Object?> get props => [description];
}
