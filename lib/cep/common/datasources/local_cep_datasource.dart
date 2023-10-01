import 'package:flutter_application_1/cep/common/model/cep_model.dart';

abstract class ILocalCepDatasource {
  Future<CepModel?> find(String cep);
  Future<void> save(CepModel cep);
  Future<void> remove(String cep);
}

