import 'package:coffee_time/generated/i18n.dart';
import 'package:flutter/material.dart';

import '../../../../../domain/entities/cafe.dart';

class BottomLine extends StatelessWidget {
  const BottomLine({
    Key key,
    @required this.cafe,
  }) : super(key: key);

  final Cafe cafe;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Spacer(),
        Text(
          cafe.openNow != null && cafe.openNow
              ? I18n.of(context).openingHours_open
              : I18n.of(context).openingHours_closed,
          style: TextStyle(
              color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
