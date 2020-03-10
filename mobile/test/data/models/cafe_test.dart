import 'dart:convert';

import 'package:coffee_time/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_helper.dart';

void main() {
  group('fromJson', () {
    test('Given valid cafe json, should return cafe model', () {
      final json = fixture('cafe.json');
      final model = cafeModelExample();
      final result = CafeModel.fromJson(jsonDecode(json));
      expect(result, model);
    });

    test('Given response without photo, should return cafe model', () {
      final json = fixture('cafe_no_photo.json');
      final model = cafeModelNoPhotoExample();
      final result = CafeModel.fromJson(jsonDecode(json));
      expect(result, model);
    });
  });
}
