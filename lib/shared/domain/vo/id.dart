import 'package:uuid/uuid.dart';

class Id {
  String _value = '';

  String get value => _value;

  Id([String? value]) {
    var uuid = const Uuid();
    _value = value ?? uuid.v4();
  }
}
