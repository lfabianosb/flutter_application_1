import 'package:flutter_application_1/cep/common/model/cep_model.dart';
import 'package:flutter_application_1/cep/consultar/consultar_cep_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_application_1/cep/common/datasources/local_cep_datasource.dart';
import 'package:flutter_application_1/cep/common/datasources/remote_cep_datasource.dart';
import 'package:flutter_application_1/cep/consultar/consultar_cep_store.dart';

class RemoteCepDatasourceMock extends Mock implements IRemoteCepDatasource {}

class LocalCepDatasourceMock extends Mock implements ILocalCepDatasource {}

void main() {
  late IRemoteCepDatasource remoteDs;
  late ILocalCepDatasource localDs;
  late ConsultarCepStore sut;
  late CepModel cepModel;

  setUp(() {
    remoteDs = RemoteCepDatasourceMock();
    localDs = LocalCepDatasourceMock();
    sut = ConsultarCepStore(
        remoteCepDataSource: remoteDs, localCepDataSource: localDs);
    cepModel = const CepModel(
      cep: 'cep',
      logradouro: 'logradouro',
      complemento: 'complemento',
      bairro: 'bairro',
      localidade: 'localidade',
      uf: 'uf',
      ibge: 1,
      ddd: 2,
    );
  });

  group('ConsultarCepStore', () {
    test('should start with InitialConsultarCepState', () {
      // Arrange
      // Act
      // Assert
      expect(sut.state, InitialConsultarCepState());
    });

    test('should emit LoadingConsultarCepState before finding cep', () async {
      // Arrange
      when(() => localDs.find(any())).thenAnswer((_) => Future.value());
      when(() => localDs.save(cepModel)).thenAnswer((_) => Future.value());
      when(() => remoteDs.find(any()))
          .thenAnswer((_) => Future.value(cepModel));
      // Act
      sut.consultar('cep');
      // Assert
      expect(sut.state, LoadingConsultarCepState());
    });

    test('should emit LoadedConsultarCepState from local datasource', () async {
      // Arrange
      when(() => localDs.find(any())).thenAnswer((_) => Future.value(cepModel));
      // Act
      await sut.consultar('cep');
      // Assert
      expect(sut.state, LoadedConsultarCepState(cep: cepModel));
    });

    test('should emit LoadedConsultarCepState from remote datasource',
        () async {
      // Arrange
      when(() => localDs.find(any())).thenAnswer((_) => Future.value());
      when(() => localDs.save(cepModel)).thenAnswer((_) => Future.value());
      when(() => remoteDs.find(any()))
          .thenAnswer((_) => Future.value(cepModel));
      // Act
      await sut.consultar('cep');
      // Assert
      expect(sut.state, LoadedConsultarCepState(cep: cepModel));
    });

    test('should emit ErrorConsultarCepState when remote find throws an error',
        () async {
      // Arrange
      when(() => localDs.find(any())).thenAnswer((_) => Future.value());
      when(() => remoteDs.find(any()))
          .thenThrow(Exception('Erro ao consultar o CEP'));
      // Act
      await sut.consultar('cep');
      // Assert
      expect(sut.state,
          ErrorConsultarCepState(description: 'Erro ao consultar o CEP cep'));
    });

    test('should emit LoadedConsultarCepState when local save throws an error',
        () async {
      // Arrange
      when(() => localDs.find(any())).thenAnswer((_) => Future.value());
      when(() => remoteDs.find(any()))
          .thenAnswer((_) => Future.value(cepModel));
      when(() => localDs.save(cepModel))
          .thenThrow(Exception('Erro ao consultar o CEP'));
      // Act
      await sut.consultar('cep');
      // Assert
      expect(sut.state, LoadedConsultarCepState(cep: cepModel));
    });
  });
}
