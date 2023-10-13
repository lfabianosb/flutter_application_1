import 'package:dio/dio.dart';

import 'package:flutter_application_1/cep/common/datasources/remote_cep_datasource.dart';
import 'package:flutter_application_1/cep/common/model/cep_model.dart';

class RemoteCepDatasourceDioAdapter implements IRemoteCepDatasource {
  final Dio _dio;

  RemoteCepDatasourceDioAdapter(Dio dio) : _dio = dio;

  @override
  Future<CepModel> find(String cep) async {
    final response = await _dio.get('https://viacep.com.br/ws/$cep/json/');
    if (response.statusCode == 200) {
      if (response.data['erro'] ?? false) {
        throw Exception('Cep não encontrado');
      }
    }
    if (response.statusCode == 400) {
      throw Exception('Cep não encontrado');
    }
    if (response.statusCode == 500) {
      throw Exception('Servidor fora');
    }
    return CepModel.fromMap(response.data);
  }
}
