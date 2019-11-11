import 'package:coffee_time/presentation/models/opening_hour.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
    List<TableRow> rows = [];
    final weekDays = getWeekDays();
    final today = DateTime.now().weekday;
    for (int i = 0; i < weekDays.length; i++) {
      final day = weekDays[i];
      final dayIndex = i + 1;
      final time = openingHours[i + 1]?.toString() ?? 'Zavřeno';
      rows.add(TableRow(children: [
        Text(
          day,
          style: today == dayIndex
              ? TextStyle(fontSize: 16, color: Theme.of(context).primaryColor)
              : TextStyle(fontSize: 16),
        ),
        Text(
          time,
          style: today == dayIndex
              ? TextStyle(fontSize: 16, color: Theme.of(context).primaryColor)
              : TextStyle(fontSize: 16),
        ),
      ]));
    }

    return Table(
      defaultColumnWidth: FractionColumnWidth(.40),
      children: rows,
    );
  }
}
