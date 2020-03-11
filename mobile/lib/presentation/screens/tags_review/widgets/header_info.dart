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
        // RichText(
        //   textAlign: TextAlign.center,
        //   text: TextSpan(
        //       text: 'Pomozte nám ',
        //       style: Theme.of(context).textTheme.subhead,
        //       children: [
        //         TextSpan(
        //             text: 'zlepšit',
        //             style: TextStyle(fontWeight: FontWeight.bold)),
        //         TextSpan(
        //           text: ' jejich přesnost.',
        //         )
        //       ]),
        // ),
        SizedBox(height: 6),
        Text(
          I18n.of(context).reviews_haederSubTitle,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        )
      ],
    );
  }
}
