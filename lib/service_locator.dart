import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_application_1/app_todo_bloc/application/list_all_tasks/list_all_tasks_cubit.dart';
import 'package:flutter_application_1/app_todo_bloc/application/save_task/save_task_cubit.dart';
import 'package:flutter_application_1/app_todo_bloc/domain/datasources/i_task_datasource.dart';
import 'package:flutter_application_1/app_todo_bloc/infra/datasources/task_datasource.dart';
import 'package:flutter_application_1/bloc_observer.dart';
import 'package:flutter_application_1/cep/common/adapters/adapters.dart';
import 'package:flutter_application_1/cep/common/datasources/datasources.dart';
import 'package:flutter_application_1/cep/common/events/events.dart';
import 'package:flutter_application_1/cep/consultar/consultar.dart';
import 'package:flutter_application_1/cep/consultar_historico/consultar_historico.dart';
import 'package:flutter_application_1/shared/domain/events/events.dart';
import 'package:flutter_application_1/shared/infra/infra.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Dio
  getIt.registerFactory<Dio>(() => Dio());

  // Event bus
  getIt.registerSingleton<IEventBus>(EventBus());

  // Consultar CEP
  getIt.registerSingleton<IRemoteCepDatasource>(
      RemoteCepDatasourceDioAdapter(getIt()));
  getIt.registerSingleton<ILocalCepDatasource>(
      LocalCepDatasourceMemoryAdapter());
  getIt.registerSingleton<ConsultarCepStore>(ConsultarCepStore(
    remoteCepDataSource: getIt(),
    localCepDataSource: getIt(),
    eventBus: getIt(),
  ));

  // Consultar histórico de CEPs
  getIt.registerSingleton<ConsultarHistoricoCepStore>(
      ConsultarHistoricoCepStore(localCepDataSource: getIt()));
  getIt.registerSingleton<CepSalvedOnLocalDsEventHandler>(
      CepSalvedOnLocalDsEventHandler(consultarHistoricoCepStore: getIt()));

  // Task
  getIt.registerSingleton<ITaskDatasource>(TaskDatasource());
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
  getIt.registerSingleton<ListAllTasksCubit>(
      ListAllTasksCubit(taskDatasource: getIt()));
  getIt
      .registerSingleton<SaveTaskCubit>(SaveTaskCubit(taskDatasource: getIt()));

  getIt.registerSingleton<MyBlocObserver>(
      MyBlocObserver(listAllTasksCubit: getIt()));
}
