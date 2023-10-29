import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_todo_bloc/application/list_all_tasks/list_all_tasks_cubit.dart';

class MyBlocObserver extends BlocObserver {
  final ListAllTasksCubit listAllTasksCubit;

  MyBlocObserver({required this.listAllTasksCubit});

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('onChange -- ${bloc.runtimeType}, $change');
    // if (change.nextState is ExecutedSaveTaskState) {
    //   listAllTasksCubit.execute();
    // }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    debugPrint('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint('onClose -- ${bloc.runtimeType}');
  }
}
