import 'package:flutter/foundation.dart';
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
          Icon(FontAwesomeIcons.dizzy, color: AppTheme.main_color),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Jejda, něco se pokazilo.'),
          ),
          if (kDebugMode)
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
