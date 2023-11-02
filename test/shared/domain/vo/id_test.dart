import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';

import 'package:flutter_application_1/shared/domain/vo/id.dart';

void main() {
  group('Id', () {
    test('should be the constructor value', () {
      var id = Id('any_id');
      expect(id.value, 'any_id');
    });

    test('should be a valid uuid', () {
      var id = Id();
      expect(Uuid.isValidUUID(fromString: id.value), isTrue);
    });
  });
}
