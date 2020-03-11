import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../generated/i18n.dart';

class NoFavorites extends StatelessWidget {
  const NoFavorites({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            FontAwesomeIcons.heart,
            size: 48,
          ),
          SizedBox(
            height: 14,
          ),
          Text(
            I18n.of(context).favorites_noFavorites,
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
