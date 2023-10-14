import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'package:flutter_application_1/cep/common/adapters/adapters.dart';
import 'package:flutter_application_1/cep/common/datasources/datasources.dart';
import 'package:flutter_application_1/cep/consultar/consultar.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerFactory<IRemoteCepDatasource>(
      () => RemoteCepDatasourceDioAdapter(Dio()));
  getIt.registerFactory<ILocalCepDatasource>(
      () => LocalCepDatasourceMemoryAdapter());
  getIt.registerSingleton<ConsultarCepStore>(ConsultarCepStore(
      remoteCepDataSource: getIt(), localCepDataSource: getIt()));
}
