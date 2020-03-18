import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/entities/cafe.dart';
import '../../../shared/shared_widgets.dart';
import 'widgets.dart';

class DetailHeader extends StatelessWidget {
  final Cafe cafe;

  const DetailHeader({
    Key key,
    @required this.cafe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Icon(
          FontAwesomeIcons.walking,
          size: 14,
          color: Theme.of(context).accentColor,
        ),
        SizedBox(width: 4),
        DistanceText(cafeLocation: cafe.location),
        SizedBox(width: 4),
        if (cafe.openNow != null)
          Icon(
            FontAwesomeIcons.clock,
            size: 14,
            color: Theme.of(context).accentColor,
          ),
        SizedBox(width: 4),
        if (cafe.openNow != null) OpensNowText(opensNow: cafe.openNow),
        Spacer(),
        if (cafe.rating != null) Rating.large(cafe.rating),
      ],
    );
  }
}
