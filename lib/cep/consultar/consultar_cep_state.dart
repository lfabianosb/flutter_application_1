import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/cep/common/model/cep_model.dart';

sealed class ConsultarCepState extends Equatable {}

class InitialConsultarCepState extends ConsultarCepState {
  @override
  List<Object?> get props => [];
}

class LoadingConsultarCepState extends ConsultarCepState {
  @override
  List<Object?> get props => [];
}

class LoadedConsultarCepState extends ConsultarCepState {
  final CepModel cep;

  LoadedConsultarCepState({required this.cep});
  
  @override
  List<Object?> get props => [cep];
}

class ErrorConsultarCepState extends ConsultarCepState {
  final String? description;

  ErrorConsultarCepState({this.description});

  @override
  List<Object?> get props => [description];
}