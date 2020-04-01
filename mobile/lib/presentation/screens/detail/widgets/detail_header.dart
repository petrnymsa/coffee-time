import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/entities/cafe.dart';
import '../../../../generated/i18n.dart';
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
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            FaIcon(
              FontAwesomeIcons.walking,
              size: 14,
              color: Theme.of(context).accentColor,
            ),
            const SizedBox(width: 4),
            DistanceText(cafeLocation: cafe.location),
            const SizedBox(width: 4),
            if (cafe.openNow != null)
              FaIcon(
                FontAwesomeIcons.clock,
                size: 14,
                color: Theme.of(context).accentColor,
              ),
            const SizedBox(width: 4),
            if (cafe.openNow != null) OpensNowText(opensNow: cafe.openNow),
            const Spacer(),
            if (cafe.rating != null) Rating.large(cafe.rating),
          ],
        ),
        if (cafe.priceLevel != null)
          Row(
            children: <Widget>[
              Text(I18n.of(context).price),
              const SizedBox(width: 2),
              Pricing(cafe.priceLevel)
            ],
          ),
      ],
    );
  }
}
