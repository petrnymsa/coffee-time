import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../shared_widgets.dart';

class FailureContainer extends StatelessWidget {
  final String message;
  final Function onRefresh;

  const FailureContainer({
    Key key,
    @required this.message,
    this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FailureMessage(
            message: message,
          ),
          Divider(indent: 60, endIndent: 60),
          if (onRefresh != null)
            FlatButton.icon(
              onPressed: onRefresh,
              icon: FaIcon(
                FontAwesomeIcons.redo,
                size: 20,
              ),
              label: Text('Obnovit'), //todo translate
            ),
        ],
      ),
    );
  }
}
