import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_application_1/cep/common/adapters/adapters.dart';
import 'package:flutter_application_1/cep/common/datasources/datasources.dart';
import 'package:flutter_application_1/cep/consultar/consultar.dart';
import 'package:flutter_application_1/cep/consultar_historico/consultar_historico.dart';
import 'package:flutter_application_1/events/events.dart';

final getIt = GetIt.instance;

void setup() {
  // Dio
  getIt.registerFactory<Dio>(() => Dio());

  // Event bus
  getIt.registerSingleton<EventBus>(EventBus());

  getIt.registerSingleton<IRemoteCepDatasource>(
      RemoteCepDatasourceDioAdapter(getIt()));
  getIt.registerSingleton<ILocalCepDatasource>(
      LocalCepDatasourceMemoryAdapter());
  getIt.registerSingleton<ConsultarCepStore>(ConsultarCepStore(
    remoteCepDataSource: getIt(),
    localCepDataSource: getIt(),
    eventBus: getIt(),
  ));
  getIt.registerSingleton<ConsultarHistoricoCepStore>(
      ConsultarHistoricoCepStore(localCepDataSource: getIt()));

  // Event bus integration
  getIt.registerSingleton<EventBusIntegration>(EventBusIntegration(
    eventBus: getIt(),
    consultarHistoricoCepStore: getIt(),
  ));
}
