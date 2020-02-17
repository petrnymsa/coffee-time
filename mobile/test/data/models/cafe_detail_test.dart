import 'package:coffee_time/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_helper.dart';

void main() {
  group('fromJson', () {
    test('Given valid cafe detail json, should return cafe detail model', () {
      final json = fixture('cafe_detail.json');
      final model = cafeModelDetailExample();
      final result = CafeDetailModel.fromJson(json);
      expect(result, model);
    });
  });
}
