import 'package:flutter/material.dart';

import 'package:flutter_application_1/cep/consultar/consultar_cep_state.dart';
import 'package:flutter_application_1/cep/common/datasources/local_cep_datasource.dart';
import 'package:flutter_application_1/cep/common/datasources/remote_cep_datasource.dart';
import 'package:flutter_application_1/cep/common/model/cep_model.dart';

class ConsultarCepStore extends ChangeNotifier {
  ConsultarCepState _state = InitialConsultarCepState();
  final IRemoteCepDatasource remoteCepDataSource;
  final ILocalCepDatasource localCepDataSource;

  ConsultarCepStore({required this.remoteCepDataSource, required this.localCepDataSource});

  ConsultarCepState get state => _state;

  Future<void> consultar(String cep) async {
    _state = LoadingConsultarCepState();
    notifyListeners();
    try {
      final CepModel? localCepModel = await localCepDataSource.find(cep);
      if (localCepModel == null) {
        final CepModel remoteCepModel = await remoteCepDataSource.find(cep);
        try {
          await localCepDataSource.save(remoteCepModel);
        } on Exception catch (e) {
          debugPrint(e.toString());
        } finally {
          _state = LoadedConsultarCepState(cep: remoteCepModel);
        }
      } else {
        _state = LoadedConsultarCepState(cep: localCepModel);
      }
    } on Exception catch (e) {
      _state = ErrorConsultarCepState(description: e.toString());
    }
    notifyListeners();
  }
}