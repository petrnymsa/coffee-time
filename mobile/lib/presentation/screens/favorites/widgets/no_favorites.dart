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
          const FaIcon(FontAwesomeIcons.heart, size: 48),
          const SizedBox(height: 14),
          Text(
            I18n.of(context).favorites_noFavorites,
            style: const TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
