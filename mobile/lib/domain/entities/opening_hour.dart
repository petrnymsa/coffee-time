import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class DayTime extends Equatable {
  final int day;
  final String time;

  DayTime({
    this.day,
    this.time,
  });

  DayTime copyWith({
    int day,
    String time,
  }) {
    return DayTime(
      day: day ?? this.day,
      time: time ?? this.time,
    );
  }

  @override
  String toString() => 'DayTime day: $day, time: $time';

  @override
  List<Object> get props => [day, time];

  List<int> toHourMinuteParts() {
    final hoursPart = time.substring(0, 2);
    final minutesPart = time.substring(2, 4);

    return [int.parse(hoursPart), int.parse(minutesPart)];
  }
}

class Period extends Equatable {
  final DayTime open;
  final DayTime close;

  bool get isNonStop => close == null && open.time == '0000';

  Period({
    @required this.open,
    this.close,
  });

  Period copyWith({
    DayTime open,
    DayTime close,
  }) {
    return Period(
      open: open ?? this.open,
      close: close ?? this.close,
    );
  }

  @override
  String toString() => 'Period open: $open, close: $close';

  @override
  List<Object> get props => [open, close];
}

class OpeningHours extends Equatable {
  final bool openNow;
  final List<Period> periods;
  final List<String> weekdayText;

  OpeningHours({this.openNow, this.periods, this.weekdayText});

  @override
  String toString() =>
      '''OpeningHours openNow: $openNow, periods: $periods, weekday: $weekdayText''';

  OpeningHours copyWith(
      {bool openNow, List<Period> periods, List<String> weekdayText}) {
    return OpeningHours(
        openNow: openNow ?? this.openNow,
        periods: periods ?? this.periods,
        weekdayText: weekdayText ?? this.weekdayText);
  }

  @override
  List<Object> get props => [openNow, periods, weekdayText];
}
