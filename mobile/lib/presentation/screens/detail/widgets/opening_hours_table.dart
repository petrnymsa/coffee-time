import 'package:coffee_time/generated/i18n.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/opening_hour.dart';

class OpeningHoursTable extends StatelessWidget {
  final Map<int, OpeningTime> openingHours;

  const OpeningHoursTable({Key key, this.openingHours})
      : assert(openingHours != null),
        super(key: key);

  List<String> getWeekDays() {
    final now = DateTime.now();
    final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
    return List.generate(7, (index) => index)
        .map((value) => DateFormat(DateFormat.WEEKDAY)
            .format(firstDayOfWeek.add(Duration(days: value))))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final rows = <TableRow>[];
    final weekDays = getWeekDays();
    final today = DateTime.now().weekday - 1;

    for (var i = 0; i < weekDays.length; i++) {
      final day = weekDays[i];
      final dayIndex = i;
      final time = openingHours[dayIndex]?.toString() ??
          I18n.of(context).openingHours_closed;
      var color = Colors.black;
      var weight = FontWeight.normal;

      if (openingHours[dayIndex] == null) {
        color = Theme.of(context).accentColor;
      } else if (today == dayIndex) {
        color = Colors.cyan;
        weight = FontWeight.bold;
      }

      rows.add(TableRow(children: [
        Text(day,
            style: TextStyle(fontSize: 16, color: color, fontWeight: weight)),
        Text(time,
            style: TextStyle(fontSize: 16, color: color, fontWeight: weight)),
      ]));
    }

    return Table(
      defaultColumnWidth: FractionColumnWidth(.40),
      children: rows,
    );
  }
}
