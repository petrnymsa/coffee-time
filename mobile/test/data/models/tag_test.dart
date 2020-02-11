import 'package:coffee_time/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_helper.dart';

void main() {
  group('fromJson', () {
    test('Given valid tag json, should return tag model', () {
      final json = fixture('tag.json');
      final model = tagExample();
      final result = TagModel.fromJson(json);
      expect(result, model);
    });
  });
}
