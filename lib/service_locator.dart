import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_application_1/app_todo/application/list_tasks/list_tasks_store.dart';
import 'package:flutter_application_1/app_todo/application/save_task/save_task_store.dart';
import 'package:flutter_application_1/app_todo/domain/datasources/i_task_datasource.dart';
import 'package:flutter_application_1/app_todo/domain/events/task_saved_event_handler.dart';
import 'package:flutter_application_1/app_todo/infra/datasources/task_datasource.dart';
import 'package:flutter_application_1/cep/common/adapters/adapters.dart';
import 'package:flutter_application_1/cep/common/datasources/datasources.dart';
import 'package:flutter_application_1/cep/common/events/events.dart';
import 'package:flutter_application_1/cep/consultar/consultar.dart';
import 'package:flutter_application_1/cep/consultar_historico/consultar_historico.dart';
import 'package:flutter_application_1/shared/application/application.dart';
import 'package:flutter_application_1/shared/domain/events/events.dart';
import 'package:flutter_application_1/shared/infra/infra.dart';

final getIt = GetIt.instance;

void setup() {
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
  getIt.registerSingleton<ListTasksStore>(
      ListTasksStore(taskDatasource: getIt()));
  getIt.registerSingleton<SaveTaskStore>(SaveTaskStore(
    taskDatasource: getIt(),
  ));
  getIt.registerSingleton<TaskSavedEventHandler>(
      TaskSavedEventHandler(listTasksStore: getIt()));

  // Event bus integration
  getIt.registerSingleton<EventBusController>(EventBusController(
    eventBus: getIt(),
    cepSalvedOnLocalDsEventHandler: getIt(),
    taskSavedEventHandler: getIt(),
  ));
}
