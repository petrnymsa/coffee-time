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
          cafe.openNow != null && cafe.openNow ? 'Otevřeno' : 'Zavřeno',
          style: TextStyle(
              color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }
}
