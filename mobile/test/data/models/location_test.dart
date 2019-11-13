import 'dart:convert';

import 'package:coffee_time/data/models/location.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromJson', () {
    test('Given valid location json, should return location model', () {
      var jsonInput = r'''{"lat": -46.0, "lng": 36.0}''';
      var model = LocationModel(lat: -46.0, lng: 36.0);

      var result = LocationModel.fromJson(json.decode(jsonInput));

      expect(result, model);
    });
  });

  group('toJson', () {
    test('Given location, valid json should return', () {
      var model = LocationModel(lat: 46.0, lng: 36.0);
      var expected = r'''{"lat":46.0,"lng":36.0}''';

      var result = jsonEncode(model);

      expect(result, expected);
    });
  });
}
