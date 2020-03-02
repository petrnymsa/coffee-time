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
}
