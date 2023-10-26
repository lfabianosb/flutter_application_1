import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/app_todo_bloc/application/list_all_tasks/list_all_tasks_cubit.dart';
import 'package:flutter_application_1/app_todo_bloc/application/save_task/save_task_cubit.dart';
import 'package:flutter_application_1/app_todo_bloc/pages/bloc_task_home_page.dart';
import 'package:flutter_application_1/bloc_observer.dart';
import 'package:flutter_application_1/service_locator.dart';

void main() {
  // getIt.get<EventBusController>().init();
  // registerListeners();

  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  Bloc.observer = getIt.get<MyBlocObserver>();
  runApp(const App());
}

// void registerListeners() {
//   var saveTaskStore = getIt.get<SaveTaskStore>();
//   var listTasksStore = getIt.get<ListTasksStore>();
//   saveTaskStore.addListener(() {
//     final state = saveTaskStore.state;
//     if (state is ExecutedSaveTaskState) {
//       listTasksStore.execute();
//     }
//   });
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: MultiProvider(
//         providers: [
//           ChangeNotifierProvider<CounterStore>(create: (_) => CounterStore()),
//           ChangeNotifierProvider<ConsultarCepStore>(
//               create: (_) => getIt.get<ConsultarCepStore>()),
//           ChangeNotifierProvider<ConsultarHistoricoCepStore>(
//               create: (_) => getIt.get<ConsultarHistoricoCepStore>()),
//           ChangeNotifierProvider<SaveTaskStore>(
//               create: (_) => getIt.get<SaveTaskStore>()),
//           ChangeNotifierProvider<ListTasksStore>(
//               create: (_) => getIt.get<ListTasksStore>()..execute()),
//         ],
//         child: const AppTodoPage(),
//       ),
//     );
//   }
// }

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AppTodoPage(),
    );
  }
}

class AppTodoPage extends StatelessWidget {
  const AppTodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => getIt.get<ListAllTasksCubit>()..execute(),
        ),
        BlocProvider(
          create: (_) => getIt.get<SaveTaskCubit>(),
        ),
      ],
      child: const BlocTaskHomePage(),
    );
  }
}
