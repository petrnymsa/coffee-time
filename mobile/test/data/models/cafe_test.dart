import 'dart:convert';
import 'dart:io';

import 'package:coffee_time/data/models/cafe.dart';
import 'package:flutter_test/flutter_test.dart' as t;

import '../../fixtures/fixture_helper.dart';

void main() {
  t.group('CafeModel', () {
    t.test("Given valid json, should return model", () {
      final jsonSample = readFixture('cafe_example.json');
      final model = exampleCafeModel();
      final j = json.decode(jsonSample);
      final result = CafeModel.fromJson(j);

      t.expect(result, model);
    });

    t.test("Can parse mock data", () {
      final jsonSample = File('assets/mock/cafe.json').readAsStringSync();
      final j = json.decode(jsonSample);
      for (final k in j) {
        final r = CafeModel.fromJson(k);
        t.expect(r, t.isNotNull);
      }
    });
  });
}
