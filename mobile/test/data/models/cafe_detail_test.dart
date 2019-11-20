import 'dart:convert';
import 'dart:io';

import 'package:coffee_time/data/models/cafe_detail.dart';
import 'package:flutter_test/flutter_test.dart' as t;

import '../../fixtures/fixture_helper.dart';

void main() {
  t.group('CafeDetailModel', () {
    t.test("Given valid json, should return model", () {
      final jsonSample = readFixture('cafe_detail_example.json');
      final model = exampleCafeDetailModel();
      final j = json.decode(jsonSample);
      final result = CafeDetailModel.fromJson(j);
      t.expect(result, model);
    });

    t.test("Can parse mock data", () {
      final jsonSample =
          File('assets/mock/cafe_detail.json').readAsStringSync();
      final j = json.decode(jsonSample);
      for (final k in j) {
        final r = CafeDetailModel.fromJson(k);
        t.expect(r, t.isNotNull);
      }
    });
  });
}
