import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_application_1/cep/common/datasources/datasources.dart';
import 'package:flutter_application_1/cep/consultar_historico/consultar_historico.dart';

class LocalCepDatasourceMock extends Mock implements ILocalCepDatasource {}

void main() {
  late ILocalCepDatasource localDs;
  late ConsultarHistoricoCepStore sut;

  setUp(() {
    localDs = LocalCepDatasourceMock();
    sut = ConsultarHistoricoCepStore(localCepDataSource: localDs);
  });

  group('ConsultarHistoricoCepStore', () {
    test('should start with InitialConsultarHistoricoCepState', () {
      // Arrange
      // Act
      // Assert
      expect(sut.state, InitialConsultarHistoricoCepState());
    });

    test(
        'should emit LoadingConsultarHistoricoCepState before finding list of ceps',
        () {
      // Arrange
      when(() => localDs.findAll()).thenAnswer((_) => Future.value([]));
      // Act
      sut.consultar();
      // Assert
      expect(sut.state, LoadingConsultarHistoricoCepState());
    });

    test(
        'should emit LoadedConsultarHistoricoCepState with an empty list of ceps',
        () async {
      // Arrange
      when(() => localDs.findAll()).thenAnswer((_) => Future.value([]));
      // Act
      await sut.consultar();
      // Assert
      expect(sut.state, LoadedConsultarHistoricoCepState(ceps: const []));
    });

    test('should emit ErrorConsultarHistoricoCepState', () async {
      // Arrange
      when(() => localDs.findAll()).thenThrow(Exception());
      // Act
      await sut.consultar();
      // Assert
      expect(
          sut.state,
          ErrorConsultarHistoricoCepState(
              description: 'Erro ao consultar o historico de CEPs'));
    });
  });
}
