import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:flutter_application_1/cep/common/datasources/datasources.dart';
import 'package:flutter_application_1/cep/common/events/events.dart';
import 'package:flutter_application_1/cep/common/model/model.dart';
import 'package:flutter_application_1/cep/consultar/consultar.dart';
import 'package:flutter_application_1/shared/domain/events/events.dart';

class RemoteCepDatasourceMock extends Mock implements IRemoteCepDatasource {}

class LocalCepDatasourceMock extends Mock implements ILocalCepDatasource {}

class EventBusMock extends Mock implements IEventBus {}

void main() {
  late IRemoteCepDatasource remoteDs;
  late ILocalCepDatasource localDs;
  late IEventBus eventBus;
  late CepModel cepModel;
  late ConsultarCepStore sut;

  setUp(() {
    remoteDs = RemoteCepDatasourceMock();
    localDs = LocalCepDatasourceMock();
    eventBus = EventBusMock();
    sut = ConsultarCepStore(
      remoteCepDataSource: remoteDs,
      localCepDataSource: localDs,
      eventBus: eventBus,
    );
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
    // Using any() as parameter
    registerFallbackValue(CepSalvedOnLocalDsEvent(cep: ''));
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
      verifyNever(() => eventBus.fire(any()));
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
      verify(() => eventBus.fire(any())).called(1);
    });

    test(
        'should emit ErrorConsultarCepState when remote finding throws an error',
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
      verifyNever(() => eventBus.fire(any()));
    });

    test(
        'should emit LoadedConsultarCepState when local saving throws an error',
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
      verifyNever(() => eventBus.fire(any()));
    });
  });
}
