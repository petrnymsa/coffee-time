import 'package:flutter/material.dart';

import '../../../../generated/i18n.dart';

class HeaderInfo extends StatelessWidget {
  const HeaderInfo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          I18n.of(context).reviews_headerTitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subhead,
        ),
      ],
    );
  }
}
