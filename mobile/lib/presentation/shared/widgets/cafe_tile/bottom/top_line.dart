import 'package:flutter/material.dart';

import '../../../../../domain/entities/cafe.dart';
import '../../../shared_widgets.dart';

class TopLine extends StatelessWidget {
  const TopLine({
    Key key,
    @required this.cafe,
  }) : super(key: key);

  final Cafe cafe;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Text(
            cafe.address,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        const SizedBox(width: 2),
        if (cafe.rating != null) Rating(cafe.rating),
      ],
    );
  }
}
