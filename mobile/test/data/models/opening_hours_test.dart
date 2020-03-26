import 'dart:convert';

import 'package:coffee_time/data/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_helper.dart';

void main() {
  group('fromJson', () {
    test('Given valid opening_hour json, should return opening hour model', () {
      final json = fixture('opening_hours.json');
      final model = openingHoursExample();
      final result = OpeningHoursModel.fromJson(jsonDecode(json));
      expect(result, model);
    });

    test('Given non-stop opening_hour json, should return opening hour model',
        () {
      final json = fixture('opening_hours_non_stop.json');
      final model = OpeningHoursModel(openNow: true, periods: [
        PeriodModel(close: null, open: DayTimeModel(day: 0, time: "0000")),
      ], weekdayText: [
        "pondělí: 7:00–24:00",
        "úterý: 7:00–24:00",
        "středa: 7:00–24:00",
        "čtvrtek: 7:00–24:00",
        "pátek: 7:00–24:00",
        "sobota: 7:00–24:00",
        "neděle: 7:00–24:00"
      ]);
      final result = OpeningHoursModel.fromJson(jsonDecode(json));
      expect(result, model);
    });
  });
}
