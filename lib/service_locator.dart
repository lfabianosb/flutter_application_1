import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_application_1/todo/stream/application/list_all_tasks/list_all_tasks_cubit.dart';
import 'package:flutter_application_1/todo/stream/application/save_task/save_task_cubit.dart';
import 'package:flutter_application_1/todo/stream/domain/repository/i_task_repository.dart';
import 'package:flutter_application_1/todo/stream/infra/repository/task_repository.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Dio
  getIt.registerFactory<Dio>(() => Dio());

  // Event bus
  // getIt.registerSingleton<IEventBus>(EventBus());

  // // Consultar CEP
  // getIt.registerSingleton<IRemoteCepDatasource>(
  //     RemoteCepDatasourceDioAdapter(getIt()));
  // getIt.registerSingleton<ILocalCepDatasource>(
  //     LocalCepDatasourceMemoryAdapter());
  // getIt.registerSingleton<ConsultarCepStore>(ConsultarCepStore(
  //   remoteCepDataSource: getIt(),
  //   localCepDataSource: getIt(),
  //   eventBus: getIt(),
  // ));

  // // Consultar histórico de CEPs
  // getIt.registerSingleton<ConsultarHistoricoCepStore>(
  //     ConsultarHistoricoCepStore(localCepDataSource: getIt()));
  // getIt.registerSingleton<CepSalvedOnLocalDsEventHandler>(
  //     CepSalvedOnLocalDsEventHandler(consultarHistoricoCepStore: getIt()));

  // Task
  // getIt.registerSingleton<ITaskDatasource>(TaskDatasource());

  getIt.registerSingleton<ITaskRepository>(TaskRepository());

  // getIt.registerSingleton<ListTasksStore>(
  //     ListTasksStore(taskDatasource: getIt()));
  // getIt.registerSingleton<SaveTaskStore>(SaveTaskStore(
  //   taskDatasource: getIt(),
  // ));
  // getIt.registerSingleton<TaskSavedEventHandler>(
  //     TaskSavedEventHandler(listTasksStore: getIt()));

  // Event bus integration
  // getIt.registerSingleton<EventBusController>(EventBusController(
  //   eventBus: getIt(),
  //   cepSalvedOnLocalDsEventHandler: getIt(),
  //   taskSavedEventHandler: getIt(),
  // ));

  // Bloc
  // getIt
  //     .registerSingleton<SaveTaskCubit>(SaveTaskCubit(taskDatasource: getIt()));
  // getIt.registerSingleton<ListAllTasksCubit>(ListAllTasksCubit(
  //   taskDatasource: getIt(),
  //   streamSaveTask: getIt<SaveTaskCubit>().stream,
  // ));

  getIt.registerSingleton<SaveTaskCubit>(SaveTaskCubit(repository: getIt()));
  getIt.registerSingleton<ListAllTasksCubit>(
      ListAllTasksCubit(repository: getIt()));

  // getIt.registerSingleton<MyBlocObserver>(
  //     MyBlocObserver(listAllTasksCubit: getIt()));
}
