import 'dart:convert';
import 'dart:io';

import 'package:coffee_time/data/models/cafe_detail.dart';
import 'package:flutter_test/flutter_test.dart' as t;

import '../../fixtures/fixture_helper.dart';

void main() {
  t.group('CafeDetailModel', () {
    t.test("Given valid json, should return model", () {
      final json_sample = readFixture('cafe_detail_example.json');
      final model = exampleCafeDetailModel();
      final j = json.decode(json_sample);
      final result = CafeDetailModel.fromJson(j);
      t.expect(result, model);
    });

    t.test("Can parse mock data", () {
      final json_sample =
          File('assets/mock/cafe_detail.json').readAsStringSync();
      final j = json.decode(json_sample);
      for (final k in j) {
        final r = CafeDetailModel.fromJson(k);
        t.expect(r, t.isNotNull);
      }
    });
  });
}
