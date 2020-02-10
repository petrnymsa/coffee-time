import 'package:coffee_time/data/models/tag_reputation.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_helper.dart';

void main() {
  group('fromJson', () {
    test('Given valid tag json, should return tag model', () {
      final json = fixture('tag_reputation.json');
      final model = tagReputationExample();
      final result = TagReputationModel.fromJson(json);
      expect(result, model);
    });
  });
}
