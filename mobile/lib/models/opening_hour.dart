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

  const OpeningTime({this.opening, this.closing});

  @override
  String toString() {
    return '$opening - $closing';
  }
}
