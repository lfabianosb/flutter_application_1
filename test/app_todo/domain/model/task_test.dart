import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/app_todo/domain/model/task.dart';
import 'package:flutter_application_1/shared/domain/vo/id.dart';

void main() {
  group('Task', () {
    test('should be created successfully', () {
      // Arrange
      // Act
      var sut = Task.create(id: Id('id'), description: 'description');
      // Assert
      expect(sut.id.value, 'id');
      expect(sut.description, 'description');
      expect(sut.finishedAt, null);
    });

    test(
        'should throw an exception when trying to finish a task with a date before a create date',
        () {
      // Arrange
      var sut = Task.create(description: 'description');
      // Act
      // Assert
      expect(
          () => sut.finish(
              finishedAt: DateTime.now().add(const Duration(minutes: -1))),
          throwsA(isA<Exception>()));
    });

    test('should finish a task with a valid date', () {
      // Arrange
      var sut = Task.create(description: 'description');
      var finishDate = DateTime.now();
      // Act
      sut = sut.finish(finishedAt: finishDate);
      // Assert
      expect(sut.description, 'description');
      expect(sut.finishedAt, finishDate);
    });
  });
}
