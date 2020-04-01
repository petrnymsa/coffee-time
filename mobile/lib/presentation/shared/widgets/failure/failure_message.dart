import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../generated/i18n.dart';
import '../../theme.dart';

class FailureMessage extends StatelessWidget {
  final String title;
  final String message;
  final IconData icon;

  const FailureMessage({
    Key key,
    this.message,
    this.icon,
    this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          FaIcon(
            icon ?? FontAwesomeIcons.dizzy,
            color: AppTheme.kMainColor,
            size: 46,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title ?? I18n.of(context).somethingWrong,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          ),
          if (kDebugMode && message != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.black45,
                ),
              ),
            )
        ],
      ),
    );
  }
}
