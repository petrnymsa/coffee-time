import 'package:flutter/material.dart';

class OpensNowText extends StatelessWidget {
  final bool opensNow;

  const OpensNowText({Key key, this.opensNow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      opensNow ? 'Otevřeno' : 'Zavřeno',
      style: Theme.of(context)
          .textTheme
          .overline
          .copyWith(fontWeight: FontWeight.w300, fontSize: 16),
    );
  }
}
