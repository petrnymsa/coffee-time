import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OpeningHoursTable extends StatelessWidget {
  // final Map<int, String> openingHours;

  const OpeningHoursTable({Key key}) : super(key: key);

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

    for (final day in weekDays) {
      rows.add(TableRow(children: [
        Text(day, style: TextStyle(fontSize: 16)),
        Text(
          '8:00 - 18:00',
          style: TextStyle(fontSize: 16),
        ),
      ]));
    }

    return Table(
      defaultColumnWidth: FractionColumnWidth(.40),
      children: rows,
      // [
      //   TableRow(
      //     children: [
      //       Text('Po'),
      //       Text('8:00 - 18:00'),
      //     ],
      //   ),
      //   TableRow(children: [
      //     Text(
      //       'Út',
      //       style: TextStyle(color: Theme.of(context).primaryColor),
      //     ),
      //     Text(
      //       '8:00 - 18:00',
      //       style: TextStyle(color: Theme.of(context).primaryColor),
      //     ),
      //   ]),
      //   TableRow(children: [
      //     Text('St'),
      //     Text('8:00 - 18:00'),
      //   ]),
      //   TableRow(children: [
      //     Text('Čt'),
      //     Text('8:00 - 18:00'),
      //   ]),
      //   TableRow(children: [
      //     Text('Pá'),
      //     Text('8:00 - 18:00'),
      //   ]),
      //   TableRow(children: [
      //     Text('So'),
      //     Text('8:00 - 18:00'),
      //   ]),
      //   TableRow(children: [
      //     Text('Ne'),
      //     Text('Zavřeno'),
      //   ])
      // ],
    );
  }
}
