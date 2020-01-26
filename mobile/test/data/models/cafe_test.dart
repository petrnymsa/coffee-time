import 'dart:convert';
import 'dart:io';

import 'package:coffee_time/data/models/cafe.dart';
import 'package:flutter_test/flutter_test.dart' as t;

import '../../fixtures/fixture_helper.dart';

void main() {
  t.group('CafeModel', () {
    t.test("Given valid json, should return model", () {
      final jsonSample = fixture('cafe_example.json');
      final model = exampleCafeModel();
      final j = json.decode(jsonSample);
      final result = CafeModel.fromJson(j);

      t.expect(result, model);
    });
  });
}
