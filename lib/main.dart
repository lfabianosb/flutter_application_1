import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:flutter_application_1/app_todo/application/list_tasks/list_tasks_store.dart';
import 'package:flutter_application_1/app_todo/application/save_task/save_task_state.dart';
import 'package:flutter_application_1/app_todo/application/save_task/save_task_store.dart';
import 'package:flutter_application_1/app_todo_bloc/application/list_all_tasks/list_all_tasks_cubit.dart';
import 'package:flutter_application_1/app_todo_bloc/pages/bloc_task_home_page.dart';
import 'package:flutter_application_1/cep/consultar/consultar.dart';
import 'package:flutter_application_1/cep/consultar_historico/consultar_historico.dart';
import 'package:flutter_application_1/counter/counter_store.dart';
import 'package:flutter_application_1/service_locator.dart';

void main() {
  setup();
  // getIt.get<EventBusController>().init();
  registerListeners();
  runApp(const MyApp());
}

void registerListeners() {
  var saveTaskStore = getIt.get<SaveTaskStore>();
  var listTasksStore = getIt.get<ListTasksStore>();
  saveTaskStore.addListener(() {
    final state = saveTaskStore.state;
    if (state is ExecutedSaveTaskState) {
      listTasksStore.execute();
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CounterStore>(create: (_) => CounterStore()),
          ChangeNotifierProvider<ConsultarCepStore>(
              create: (_) => getIt.get<ConsultarCepStore>()),
          ChangeNotifierProvider<ConsultarHistoricoCepStore>(
              create: (_) => getIt.get<ConsultarHistoricoCepStore>()),
          ChangeNotifierProvider<SaveTaskStore>(
              create: (_) => getIt.get<SaveTaskStore>()),
          ChangeNotifierProvider<ListTasksStore>(
              create: (_) => getIt.get<ListTasksStore>()..execute()),
        ],
        child: const AppTodoPage(),
      ),
    );
  }
}

class AppTodoPage extends StatelessWidget {
  const AppTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<ListAllTasksCubit>(),
      child: const BlocTaskHomePage(),
    );
  }
}
