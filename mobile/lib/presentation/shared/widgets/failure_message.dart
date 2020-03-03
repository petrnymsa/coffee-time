import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../theme.dart';

class FailureMessage extends StatelessWidget {
  final String message;

  const FailureMessage({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Icon(FontAwesomeIcons.exclamationCircle, color: AppTheme.main_color),
          Text(
            message,
            style: TextStyle(
              color: AppTheme.main_color,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
