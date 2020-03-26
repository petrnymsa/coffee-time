import 'package:intl/intl.dart';

class HourMinute {
  final int hour;
  final int minute;

  const HourMinute(this.hour, this.minute);

  @override
  String toString() {
    return '$hour:${NumberFormat('00').format(minute)}';
  }
}

class OpeningTime {
  final HourMinute opening;
  final HourMinute closing;

  bool get isNonstop =>
      closing == null && opening.hour == 0 && opening.minute == 0;

  const OpeningTime({this.opening, this.closing});

  factory OpeningTime.nonStop() =>
      OpeningTime(opening: HourMinute(0, 0), closing: null);

  @override
  String toString() {
    return '$opening - $closing';
  }
}
