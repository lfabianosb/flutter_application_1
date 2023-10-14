import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_application_1/cep/common/adapters/adapters.dart';
import 'package:flutter_application_1/cep/common/datasources/datasources.dart';
import 'package:flutter_application_1/cep/consultar/consultar.dart';
import 'package:flutter_application_1/cep/consultar_historico/consultar_historico.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerFactory<IRemoteCepDatasource>(
      () => RemoteCepDatasourceDioAdapter(Dio()));
  getIt.registerSingleton<ILocalCepDatasource>(
      LocalCepDatasourceMemoryAdapter());
  getIt.registerSingleton<ConsultarCepStore>(ConsultarCepStore(
      remoteCepDataSource: getIt(), localCepDataSource: getIt()));
  getIt.registerSingleton<ConsultarHistoricoCepStore>(
      ConsultarHistoricoCepStore(localCepDataSource: getIt()));
}
