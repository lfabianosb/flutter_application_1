import 'package:dio/dio.dart';
import 'package:flutter_application_1/cep/common/adapters/remote_cep_datasource_exception.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/cep/common/adapters/remote_cep_datasource_dio_adapter.dart';
import 'package:flutter_application_1/cep/common/model/cep_model.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() {
  late RemoteCepDatasourceDioAdapter sut;
  late Dio dio;
  late DioAdapter dioAdapter;
  const cepJson =
      '''{
      "cep": "58043-330",
      "logradouro": "Rua do Sol",
      "complemento": "",
      "bairro": "Miramar",
      "localidade": "João Pessoa",
      "uf": "PB",
      "ibge": "2507507",
      "ddd": "83"
    }''';
  final cepModel = CepModel.fromJson(cepJson);

  setUp(() {
    dio = Dio();
    dioAdapter = DioAdapter(dio: dio);
    sut = RemoteCepDatasourceDioAdapter(dio);
  });

  group('RemoteCepDatasourceDioAdapter', () {
    test('should find a valid cep', () async {
      // Arrange
      const validCep = '58043330';
      dioAdapter.onGet('https://viacep.com.br/ws/$validCep/json/', (server) {
        server.reply(
          200,
          {
            "cep": "58043-330",
            "logradouro": "Rua do Sol",
            "complemento": "",
            "bairro": "Miramar",
            "localidade": "João Pessoa",
            "uf": "PB",
            "ibge": "2507507",
            "ddd": "83"
          },
        );
      });
      // Act
      final result = await sut.find(validCep);
      // Assert
      expect(result, cepModel);
    });

    test('should throws an Exception when searching an invalid cep', () {
      // Arrange
      const invalidCep = '12345678';
      dioAdapter.onGet('https://viacep.com.br/ws/$invalidCep/json/', (server) {
        server.reply(
          200,
          {"erro": true},
        );
      });
      // Act
      // Assert
      expect(
          () async => await sut.find(invalidCep),
          throwsA(isA<RemoteCepDatasourceException>().having(
              (error) => error.message,
              'message',
              'Erro ao consultar o CEP $invalidCep')));
    });

    test('should throws an Exception when searching an incomplete cep', () {
      // Arrange
      const incompleteCep = '5804333';
      dioAdapter.onGet('https://viacep.com.br/ws/$incompleteCep/json/',
          (server) {
        server.reply(
          400,
          {},
        );
      });
      // Act
      // Assert
      expect(
          () async => await sut.find(incompleteCep),
          throwsA(isA<RemoteCepDatasourceException>().having(
              (error) => error.message,
              'message',
              'CEP $incompleteCep não encentrado')));
    });

    test('should throws an Exception when remote server is down', () {
      // Arrange
      const anyCep = '5804333';
      dioAdapter.onGet('https://viacep.com.br/ws/$anyCep/json/', (server) {
        server.reply(
          500,
          {},
        );
      });
      // Act
      // Assert
      expect(
          () async => await sut.find(anyCep),
          throwsA(isA<RemoteCepDatasourceException>().having(
              (error) => error.message, 'message', 'Servidor fora do ar')));
    });
  });
}
