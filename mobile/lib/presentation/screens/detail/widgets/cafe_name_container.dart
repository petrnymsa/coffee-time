import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/entities/cafe.dart';
import '../../../../generated/i18n.dart';

class CafeNameContainer extends StatelessWidget {
  final Cafe cafe;
  final Function onShowMap;
  const CafeNameContainer({Key key, @required this.cafe, this.onShowMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SelectableText(
            cafe.name,
            style: Theme.of(context).textTheme.headline,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: SelectableText(
              cafe.address,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          if (kDebugMode)
            Container(
              padding: const EdgeInsets.only(top: 6.0),
              child: SelectableText(
                cafe.placeId,
                style: TextStyle(color: Colors.black38),
              ),
            ),
          FlatButton.icon(
            icon: FaIcon(FontAwesomeIcons.locationArrow),
            label: Text(I18n.of(context).detail_navigate),
            onPressed: onShowMap,
          )
        ],
      ),
    );
  }
}
