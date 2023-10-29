// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

// ignore: must_be_immutable
class Id extends Equatable {
  String _value = '';

  String get value => _value;

  Id([String? value]) {
    var uuid = const Uuid();
    _value = value ?? uuid.v4();
  }

  @override
  List<Object?> get props => [_value];
}
