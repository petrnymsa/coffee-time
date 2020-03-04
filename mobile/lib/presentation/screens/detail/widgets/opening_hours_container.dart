import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/entities/opening_hour.dart';
import '../../../models/opening_hour.dart';
import '../../../shared/shared_widgets.dart';
import 'opening_hours_table.dart';

class OpeningHoursContainer extends StatelessWidget {
  final OpeningHours openingHours;

  const OpeningHoursContainer({
    @required this.openingHours,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      expanded: true,
      header: SectionHeader(
        icon: FontAwesomeIcons.clock,
        title: 'Otevírací doba', //todo translate
      ),
      body: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: OpeningHoursTable(
            // openingHours: {
            //   1: const OpeningTime(
            //       opening: const HourMinute(8, 0),
            //       closing: const HourMinute(16, 0)),
            //   2: const OpeningTime(
            //       opening: const HourMinute(8, 0),
            //       closing: const HourMinute(16, 0)),
            //   3: const OpeningTime(
            //       opening: const HourMinute(8, 0),
            //       closing: const HourMinute(16, 0)),
            //   4: const OpeningTime(
            //       opening: const HourMinute(8, 0),
            //       closing: const HourMinute(16, 0)),
            //   5: const OpeningTime(
            //       opening: const HourMinute(8, 0),
            //       closing: const HourMinute(16, 0)),
            //   6: const OpeningTime(
            //       opening: const HourMinute(8, 0),
            //       closing: const HourMinute(16, 0)),
            //   7: null,
            // },
            openingHours: _mapOpeningHoursToViewModel(),
          ),
        ),
      ),
    );
  }

  Map<int, OpeningTime> _mapOpeningHoursToViewModel() {
    final result = <int, OpeningTime>{};

    for (final p in openingHours.periods) {
      final open = p.open.toHourMinuteParts();
      final close = p.close.toHourMinuteParts();

      result[p.open.day] = OpeningTime(
        opening: HourMinute(open[0], open[1]),
        closing: HourMinute(close[0], close[1]),
      );
    }

    return result;
  }
}
