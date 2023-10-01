import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:flutter_application_1/cep/common/datasources/remote_cep_datasource.dart';
import 'package:flutter_application_1/cep/common/model/cep_model.dart';

class RemoteCepDatasourceDioAdapter implements IRemoteCepDatasource {
  final Dio _dio = Dio();

  @override
  Future<CepModel> find(String cep) async {
    debugPrint('find by remote ds');
    final response = await _dio.get('https://viacep.com.br/ws/$cep/json/');
    if (response.statusCode == 400) {
      throw Exception('Cep não encontrado');
    }
    if (response.statusCode == 500) {
      throw Exception('Servidor fora');
    }
    return CepModel.fromMap(response.data);
  }
}