import 'package:flutter_application_1/cep/common/model/cep_model.dart';

abstract class IRemoteCepDatasource {
  Future<CepModel> find(String cep);
}

