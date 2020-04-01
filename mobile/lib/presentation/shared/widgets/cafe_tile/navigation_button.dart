import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/entities/cafe.dart';

class NavigationButton extends StatelessWidget {
  final Function onPressed;

  const NavigationButton(
      {Key key,
      @required this.radius,
      @required this.cafe,
      @required this.onPressed})
      : super(key: key);

  final double radius;
  final Cafe cafe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        padding: const EdgeInsets.only(left: 2.0, bottom: 2.0),
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor.withAlpha(200),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(radius),
            topLeft: Radius.circular(radius),
          ),
        ),
        child: IconButton(
          icon: const FaIcon(
            FontAwesomeIcons.locationArrow,
            size: 24,
          ),
          onPressed: () => onPressed(cafe),
        ),
      ),
    );
  }
}
