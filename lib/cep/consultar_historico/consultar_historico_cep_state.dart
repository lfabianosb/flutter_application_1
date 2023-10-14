import 'package:equatable/equatable.dart';

import 'package:flutter_application_1/cep/common/model/model.dart';

sealed class ConsultarHistoricoCepState extends Equatable {}

class InitialConsultarHistoricoCepState extends ConsultarHistoricoCepState {
  @override
  List<Object?> get props => [];
}

class LoadingConsultarHistoricoCepState extends ConsultarHistoricoCepState {
  @override
  List<Object?> get props => [];
}

class LoadedConsultarHistoricoCepState extends ConsultarHistoricoCepState {
  final List<CepModel> ceps;

  LoadedConsultarHistoricoCepState({required this.ceps});

  @override
  List<Object?> get props => [ceps];
}

class ErrorConsultarHistoricoCepState extends ConsultarHistoricoCepState {
  final String? description;

  ErrorConsultarHistoricoCepState({this.description});

  @override
  List<Object?> get props => [description];
}
