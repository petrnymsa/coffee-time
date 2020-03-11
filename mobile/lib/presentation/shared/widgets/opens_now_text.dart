import 'package:flutter/material.dart';

import '../../../generated/i18n.dart';

class OpensNowText extends StatelessWidget {
  final bool opensNow;

  const OpensNowText({Key key, this.opensNow}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tr = I18n.of(context);
    return Text(
      opensNow ? tr.openingHours_open : tr.openingHours_closed,
      style: Theme.of(context)
          .textTheme
          .overline
          .copyWith(fontWeight: FontWeight.w300, fontSize: 16),
    );
  }
}
