import 'package:flutter_application_1/shared/domain/vo/id.dart';

abstract class IEntity<ID extends Id> {
  final ID id;

  IEntity({required this.id});
}
