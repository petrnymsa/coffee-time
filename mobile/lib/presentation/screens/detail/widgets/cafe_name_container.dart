import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CafeNameContainer extends StatelessWidget {
  final String title;

  final String address;
  final Function onShowMap;
  const CafeNameContainer(
      {Key key, @required this.title, @required this.address, this.onShowMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SelectableText(
            title,
            style: Theme.of(context).textTheme.headline,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: SelectableText(
              address,
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          FlatButton.icon(
            icon: Icon(FontAwesomeIcons.locationArrow),
            label: Text('Navigate'),
            onPressed: onShowMap,
          )
        ],
      ),
    );
  }
}
