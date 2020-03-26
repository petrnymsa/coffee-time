import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Pricing extends StatelessWidget {
  final int priceLevel;

  Pricing(this.priceLevel);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (var i = 0; i < priceLevel; i++)
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Icon(
              FontAwesomeIcons.coins,
              size: 10,
              color: Theme.of(context).accentColor,
            ),
          ),
      ],
    );
  }
}
