import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:flutter_application_1/app_todo/list_tasks/list_tasks_store.dart';
import 'package:flutter_application_1/app_todo/pages/task_home_page.dart';
import 'package:flutter_application_1/app_todo/save_task/save_task_store.dart';
import 'package:flutter_application_1/cep/consultar/consultar.dart';
import 'package:flutter_application_1/cep/consultar_historico/consultar_historico.dart';
import 'package:flutter_application_1/counter/counter_store.dart';
import 'package:flutter_application_1/service_locator.dart';
import 'package:flutter_application_1/shared/application/application.dart';

void main() {
  setup();
  getIt.get<EventBusController>().init();
  runApp(const MyApp());
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
              create: (_) => getIt.get<ListTasksStore>()),
        ],
        child: const TaskHomePage(),
      ),
    );
  }
}
