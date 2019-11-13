import 'dart:convert';

import 'package:coffee_time/data/models/photo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromJson', () {
    test('Given valid photo json, should return photo model', () {
      var jsonInput =
          r'''{"photo_reference": "test.url", "width": 100, "height": 60}''';
      var model = PhotoModel(url: "test.url", width: 100, height: 60);

      var result = PhotoModel.fromJson(json.decode(jsonInput));

      expect(result, model);
    });
  });

  group('toJson', () {
    test('Given photo, valid json should return', () {
      var model = PhotoModel(url: "test.url", width: 100, height: 60);
      var expected =
          r'''{"photo_reference":"test.url","width":100,"height":60}''';

      var result = jsonEncode(model);

      expect(result, expected);
    });
  });
}
