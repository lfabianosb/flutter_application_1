import 'package:dio/dio.dart';

import 'package:flutter_application_1/cep/common/adapters/remote_cep_datasource_exception.dart';
import 'package:flutter_application_1/cep/common/datasources/remote_cep_datasource.dart';
import 'package:flutter_application_1/cep/common/model/cep_model.dart';

class RemoteCepDatasourceDioAdapter implements IRemoteCepDatasource {
  final Dio _dio;

  RemoteCepDatasourceDioAdapter(Dio dio) : _dio = dio;

  @override
  Future<CepModel> find(String cep) async {
    Response response;
    try {
      response = await _dio.get('https://viacep.com.br/ws/$cep/json/');
      if (response.statusCode == 200) {
        if (response.data?['erro'] ?? false) {
          throw RemoteCepDatasourceException(
              message: 'Erro ao consultar o CEP $cep');
        }
      }
      return CepModel.fromMap(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw RemoteCepDatasourceException(message: 'CEP $cep não encentrado');
      }
      if (e.response?.statusCode == 500) {
        throw RemoteCepDatasourceException(message: 'Servidor fora do ar');
      }
      throw RemoteCepDatasourceException(
          message: e.message ?? 'Erro desconhecido');
    }
  }
}
