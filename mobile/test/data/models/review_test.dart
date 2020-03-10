import 'dart:convert';

import 'package:coffee_time/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_helper.dart';

void main() {
  group('fromJson', () {
    test('Given valid review json, should return review model', () {
      final json = fixture('review.json');
      final model = reviewExample();
      final result = ReviewModel.fromJson(jsonDecode(json));
      expect(result, model);
    });
  });
}
