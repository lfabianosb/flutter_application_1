import 'package:equatable/equatable.dart';

import 'package:flutter_application_1/shared/domain/model/i_entity.dart';
import 'package:flutter_application_1/shared/domain/vo/id.dart';

class Task extends IEntity with EquatableMixin {
  final String description;
  final DateTime createdAt;
  final DateTime? finishedAt;

  Task._({
    required super.id,
    required this.description,
    required this.createdAt,
    this.finishedAt,
  });

  factory Task.create({
    Id? id,
    required String description,
  }) {
    return Task._(
      id: id ?? Id(),
      description: description,
      createdAt: DateTime.now(),
      finishedAt: null,
    );
  }

  Task finish({DateTime? finishedAt}) {
    if (_dateIsBeforeThanCreateDate(finishedAt) ||
        _dateIsBeforeThanCreateDate(DateTime.now())) {
      throw Exception(
          'Data de término não pode ser anterior à data de criação');
    }
    return Task._(
      id: id,
      description: description,
      createdAt: createdAt,
      finishedAt: finishedAt ?? DateTime.now(),
    );
  }

  bool _dateIsBeforeThanCreateDate(DateTime? date) {
    return date != null && date.isBefore(createdAt);
  }

  @override
  List<Object?> get props => [id, description, createdAt, finishedAt];
}
