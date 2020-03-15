import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../generated/i18n.dart';

class NoData extends StatelessWidget {
  const NoData({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            Icon(FontAwesomeIcons.coffee),
            Text(I18n.of(context).cafeList_noCafes)
          ],
        ),
      ),
    );
  }
}
