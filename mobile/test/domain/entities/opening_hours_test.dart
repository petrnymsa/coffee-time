import 'package:coffee_time/data/models/models.dart';
import 'package:coffee_time/domain/entities/opening_hour.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('daytime', () {
    test('toHoursMinutePart', () {
      final time = DayTime(day: 0, time: "1100");

      expect(time.toHourMinuteParts(), equals([11, 00]));
    });

    test('toHoursMinutePart2', () {
      final time = DayTime(day: 0, time: "1823");

      expect(time.toHourMinuteParts(), equals([18, 23]));
    });
  });

  test('Given nonstop model, should return entity', () {
    final periodModel =
        PeriodModel(close: null, open: DayTimeModel(day: 0, time: "0000"));

    final entity = periodModel.toEntity();

    expect(entity, Period(close: null, open: DayTime(day: 0, time: "0000")));
    expect(entity.isNonStop, isTrue);
  });
}
