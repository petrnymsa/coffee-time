import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../generated/i18n.dart';
import '../models/opening_time.dart';

class OpeningHoursTable extends StatelessWidget {
  final Map<int, OpeningTime> openingHours;

  const OpeningHoursTable({Key key, this.openingHours})
      : assert(openingHours != null),
        super(key: key);

  List<String> _getWeekDays() {
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(7, (index) => index)
        .map((value) => DateFormat(DateFormat.WEEKDAY)
            .format(firstDayOfWeek.add(Duration(days: value))))
        .toList();
  }

  String _getTimeString(BuildContext context, OpeningTime time) {
    if (time != null) {
      return time.isNonstop ? 'nonstop' : time.toString();
    }
    return I18n.of(context).openingHours_closed;
  }

  @override
  Widget build(BuildContext context) {
    final rows = <TableRow>[];
    final weekDays = _getWeekDays();
    final today = DateTime.now().weekday - 1;

    for (var i = 0; i < weekDays.length; i++) {
      final day = weekDays[i];
      final dayIndex = i;
      final openingTime = openingHours[dayIndex];

      var timeString = _getTimeString(context, openingTime);

      var color = Colors.black;
      var weight = FontWeight.normal;

      if (openingTime == null) {
        color = Theme.of(context).accentColor;
      } else if (today == dayIndex) {
        color = Colors.cyan;
        weight = FontWeight.bold;
      }

      rows.add(TableRow(children: [
        Text(day,
            style: TextStyle(fontSize: 16, color: color, fontWeight: weight)),
        Text(timeString,
            style: TextStyle(fontSize: 16, color: color, fontWeight: weight)),
      ]));
    }

    return Table(
      defaultColumnWidth: FractionColumnWidth(.40),
      children: rows,
    );
  }
}
