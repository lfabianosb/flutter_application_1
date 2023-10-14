import 'package:flutter/material.dart';

import 'package:flutter_application_1/cep/common/datasources/datasources.dart';
import 'package:flutter_application_1/cep/consultar_historico/consultar_historico.dart';

class ConsultarHistoricoCepStore extends ChangeNotifier {
  ConsultarHistoricoCepState _state = InitialConsultarHistoricoCepState();
  final ILocalCepDatasource localCepDataSource;

  ConsultarHistoricoCepStore({required this.localCepDataSource});

  ConsultarHistoricoCepState get state => _state;

  Future<void> consultar() async {
    _state = LoadingConsultarHistoricoCepState();
    notifyListeners();
    try {
      final localCepsModel = await localCepDataSource.findAll();
      _state = LoadedConsultarHistoricoCepState(ceps: localCepsModel);
    } on Exception {
      _state = ErrorConsultarHistoricoCepState(
          description: 'Erro ao consultar o historico de CEPs');
    }
    notifyListeners();
  }
}
