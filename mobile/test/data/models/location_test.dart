import 'package:coffee_time/data/models/location.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromJson', () {
    test('Given valid location json, should return location model', () {
      const jsonInput = r'''{"lat": -46.0, "lng": 36.0}''';
      const model = LocationModel(lat: -46.0, lng: 36.0);

      final result = LocationModel.fromJson(jsonInput);

      expect(result, model);
    });
  });
}
