import 'package:flutter_application_1/cep/common/model/model.dart';

abstract class IRemoteCepDatasource {
  Future<CepModel> find(String cep);
}
