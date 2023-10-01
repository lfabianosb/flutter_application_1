import 'package:get_it/get_it.dart';

import 'package:flutter_application_1/cep/common/adapters/local_cep_datasource_memory_adapter.dart';
import 'package:flutter_application_1/cep/common/adapters/remote_cep_datasource_dio_adapter.dart';
import 'package:flutter_application_1/cep/consultar/consultar_cep_store.dart';
import 'package:flutter_application_1/cep/common/datasources/local_cep_datasource.dart';
import 'package:flutter_application_1/cep/common/datasources/remote_cep_datasource.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerFactory<IRemoteCepDatasource>(() => RemoteCepDatasourceDioAdapter());
  getIt.registerFactory<ILocalCepDatasource>(() => LocalCepDatasourceMemoryAdapter());
  getIt.registerSingleton<ConsultarCepStore>(ConsultarCepStore(remoteCepDataSource: getIt(), localCepDataSource: getIt()));
}