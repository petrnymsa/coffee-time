import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../generated/i18n.dart';
import 'failure_message.dart';

class FailureContainer extends StatelessWidget {
  final String title;
  final String message;
  final IconData titleIcon;
  final Function onRefresh;
  final String refreshText;
  final IconData refreshIcon;

  const FailureContainer({
    Key key,
    this.title,
    this.message,
    this.onRefresh,
    this.titleIcon,
    this.refreshText,
    this.refreshIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FailureMessage(
            title: title,
            message: message,
            icon: titleIcon,
          ),
          Divider(indent: 60, endIndent: 60),
          if (onRefresh != null)
            FlatButton.icon(
              onPressed: onRefresh,
              icon: FaIcon(
                refreshIcon ?? FontAwesomeIcons.redo,
                size: 20,
              ),
              label: Text(refreshText ?? I18n.of(context).refresh),
            ),
        ],
      ),
    );
  }
}
