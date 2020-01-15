import 'package:coffee_time/presentation/models/opening_hour.dart';
import 'package:coffee_time/presentation/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'opening_hours_table.dart';

class OpeningHoursContainer extends StatelessWidget {
  const OpeningHoursContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      expanded: true,
      header: SectionHeader(
        icon: FontAwesomeIcons.clock,
        title: 'Otevírací doba',
      ),
      body: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: OpeningHoursTable(
            openingHours: {
              1: const OpeningTime(
                  opening: const HourMinute(8, 0),
                  closing: const HourMinute(16, 0)),
              2: const OpeningTime(
                  opening: const HourMinute(8, 0),
                  closing: const HourMinute(16, 0)),
              3: const OpeningTime(
                  opening: const HourMinute(8, 0),
                  closing: const HourMinute(16, 0)),
              4: const OpeningTime(
                  opening: const HourMinute(8, 0),
                  closing: const HourMinute(16, 0)),
              5: const OpeningTime(
                  opening: const HourMinute(8, 0),
                  closing: const HourMinute(16, 0)),
              6: const OpeningTime(
                  opening: const HourMinute(8, 0),
                  closing: const HourMinute(16, 0)),
              7: null,
            },
          ),
        ),
      ),
    );
  }
}
