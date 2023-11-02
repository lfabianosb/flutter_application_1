import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Id extends Equatable {
  final String _value;

  String get value => _value;

  Id([String? value]) : _value = value ?? const Uuid().v4();

  @override
  List<Object?> get props => [_value];
}
