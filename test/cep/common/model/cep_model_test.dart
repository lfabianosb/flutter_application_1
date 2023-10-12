import 'package:flutter_application_1/cep/common/model/cep_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const cepJson = '''
    {
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
    }
  ''';
  const cepModel = CepModel(
    cep: '58043330',
    logradouro: 'Rua do Sol',
    complemento: '',
    bairro: 'Miramar',
    localidade: 'João Pessoa',
    uf: 'PB',
    ibge: 2507507,
    ddd: 83,
  );
  const cepMap = {
    "cep": "58043330",
    "logradouro": "Rua do Sol",
    "complemento": "",
    "bairro": "Miramar",
    "localidade": "João Pessoa",
    "uf": "PB",
    "ibge": 2507507,
    "ddd": 83,
  };

  group('CepModel', () {
    test('should create a CepModel from json', () {
      // Arrange
      // Act
      final model = CepModel.fromJson(cepJson);
      // Assert
      expect(model, cepModel);
    });

    test('should create a map from CepModel', () {
      // Arrange
      // Act
      final map = cepModel.toMap();
      // Assert
      expect(map, cepMap);
    });
  });
}
