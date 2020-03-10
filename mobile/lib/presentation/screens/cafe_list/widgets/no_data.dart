import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
            Text('Žádné kavárny neodpovídají hledání') //todo translate
          ],
        ),
      ),
    );
  }
}
