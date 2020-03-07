import 'package:coffee_time/data/models/tag_update.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromJson', () {
    test('Should return valid model', () {
      final jsonInput = '''{"id":"abc","change":"like"}''';

      final result = TagUpdate.fromJson(jsonInput);

      expect(result, equals(TagUpdate(id: 'abc', change: TagUpdateKind.like)));
    });
  });

  group('toJson', () {
    test('Should return valid json', () {
      final expectedJson = '''{"id":"abc","change":"like"}''';

      final tagUpdate = TagUpdate(id: 'abc', change: TagUpdateKind.like);
      final result = tagUpdate.toJson();

      expect(result, equals(expectedJson));
    });
  });
}
