import 'package:coffee_time/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_helper.dart';

void main() {
  group('fromJson', () {
    test('Given valid opening_hour json, should return opening hour model', () {
      final json = fixture('opening_hours.json');
      final model = openingHoursExample();
      final result = OpeningHoursModel.fromJson(json);
      expect(result, model);
    });
  });
}
