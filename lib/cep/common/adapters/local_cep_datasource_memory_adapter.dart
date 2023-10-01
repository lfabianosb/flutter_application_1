import 'package:flutter/material.dart';

import 'package:flutter_application_1/cep/common/datasources/local_cep_datasource.dart';
import 'package:flutter_application_1/cep/common/model/cep_model.dart';

class LocalCepDatasourceMemoryAdapter implements ILocalCepDatasource {
  final List<CepModel> _ceps = [];

  @override
  Future<CepModel?> find(String cep) async {
    final result = _ceps.where((c) => c.cep == cep);
    debugPrint('find by LOCAL ds');
    return result.firstOrNull;
  }
  
  @override
  Future<void> remove(String cep) async {
    _ceps.removeWhere((c) => c.cep == cep);
  }
  
  @override
  Future<void> save(CepModel cep) async {
    final result = _ceps.where((c) => c.cep == cep.cep);
    if (result.isEmpty) {
      _ceps.add(cep);
    }
  }
}