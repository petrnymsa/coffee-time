import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/opening_hour.dart';

//ignore_for_file: unnecessary_lambdas
class DayTimeModel extends Equatable {
  final int day;
  final String time;

  DayTimeModel({
    @required this.day,
    @required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'time': time,
    };
  }

  static DayTimeModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return DayTimeModel(
      day: map['day'],
      time: map['time'],
    );
  }

  DayTimeModel copyWith({
    int day,
    String time,
  }) {
    return DayTimeModel(
      day: day ?? this.day,
      time: time ?? this.time,
    );
  }

  @override
  String toString() => 'DayTimeModel day: $day, time: $time';

  @override
  List<Object> get props => [day, time];

  DayTime toEntity() => DayTime(day: day, time: time);
}

class PeriodModel extends Equatable {
  final DayTimeModel open;
  final DayTimeModel close;

  PeriodModel({
    @required this.open,
    @required this.close,
  });

  Map<String, dynamic> toJson() {
    return {
      'open': open.toJson(),
      'close': close.toJson(),
    };
  }

  static PeriodModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return PeriodModel(
      open: DayTimeModel.fromJson(map['open']),
      close: DayTimeModel.fromJson(map['close']),
    );
  }

  PeriodModel copyWith({
    DayTimeModel open,
    DayTimeModel close,
  }) {
    return PeriodModel(
      open: open ?? this.open,
      close: close ?? this.close,
    );
  }

  @override
  String toString() => 'PeriodModel open: $open, close: $close';

  @override
  List<Object> get props => [open, close];

  Period toEntity() => Period(close: close?.toEntity(), open: open.toEntity());
}

class OpeningHoursModel extends Equatable {
  final bool openNow;
  final List<PeriodModel> periods;
  final List<String> weekdayText;

  OpeningHoursModel({this.openNow, this.periods, this.weekdayText});

  Map<String, dynamic> toJson() {
    return {
      'open_now': openNow,
      'periods': List<dynamic>.from(
        periods.map((x) => x.toJson()),
      ),
      'weekday_text': weekdayText
    };
  }

  static OpeningHoursModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return OpeningHoursModel(
        openNow: map['open_now'],
        periods: List<PeriodModel>.from(
            map['periods']?.map((x) => PeriodModel.fromJson(x))),
        weekdayText: List<String>.from(map['weekday_text']?.map((x) => x)));
  }

  @override
  String toString() =>
      '''OpeningHoursModel openNow: $openNow, periods: $periods, weekday: $weekdayText''';

  OpeningHoursModel copyWith(
      {bool openNow, List<PeriodModel> periods, List<String> weekdayText}) {
    return OpeningHoursModel(
        openNow: openNow ?? this.openNow,
        periods: periods ?? this.periods,
        weekdayText: weekdayText ?? this.weekdayText);
  }

  @override
  List<Object> get props => [openNow, periods, weekdayText];

  OpeningHours toEntity() => OpeningHours(
        openNow: openNow,
        weekdayText: weekdayText,
        periods: periods.map((x) => x.toEntity()).toList(),
      );
}
