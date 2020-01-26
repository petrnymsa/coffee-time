import 'dart:convert';
import 'dart:io';

import 'package:coffee_time/data/models/cafe_detail.dart';
import 'package:flutter_test/flutter_test.dart' as t;
import 'package:intl/date_symbol_data_local.dart';

import '../../fixtures/fixture_helper.dart';

void main() {
  t.group('CafeDetailModel', () {
    t.test("Given valid json, should return model", () async {
      await initializeDateFormatting('en');

      final jsonSample = fixture('cafe_detail_example.json');
      final model = exampleCafeDetailModel();
      final j = json.decode(jsonSample);
      final result = CafeDetailModel.fromJson(j);
      t.expect(result, model);
    });
  });
}
