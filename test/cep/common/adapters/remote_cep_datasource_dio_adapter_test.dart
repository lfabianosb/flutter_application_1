import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/cep/common/adapters/remote_cep_datasource_dio_adapter.dart';
import 'package:flutter_application_1/cep/common/model/cep_model.dart';

void main() {
  late RemoteCepDatasourceDioAdapter sut;
  const cepJson = '''{
      "cep": "58043-330",
      "logradouro": "Rua do Sol",
      "complemento": "",
      "bairro": "Miramar",
      "localidade": "João Pessoa",
      "uf": "PB",
      "ibge": "2507507",
      "gia": "",
      "ddd": "83",
      "siafi": "2051"
    }''';
  final cepModel = CepModel.fromJson(cepJson);

  setUp(() {
    sut = RemoteCepDatasourceDioAdapter();
  });

  group('RemoteCepDatasourceDioAdapter', () {
    test('should find a valid cep', () async {
      // Arrange
      // Act
      final cep = await sut.find('58043330');
      // Assert
      expect(cep, cepModel);
    });

    test('should throws an Exception when searching an invalid cep', () {
      // Arrange
      const invalidCep = '12345678';
      // Act
      // Assert
      expect(() async => await sut.find(invalidCep), throwsA(isA<Exception>()));
    });

    test('should throws an Exception when searching an incomplete cep', () {
      // Arrange
      const incompleteCep = '5804333';
      // Act
      // Assert
      expect(
          () async => await sut.find(incompleteCep), throwsA(isA<Exception>()));
    });
  });
}
