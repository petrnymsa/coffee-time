import 'package:flutter/material.dart';

import '../../../../domain/entities/cafe.dart';
import '../../../shared/shared_widgets.dart';

class DetailHeader extends StatelessWidget {
  final Cafe cafe;

  const DetailHeader({
    Key key,
    @required this.cafe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        OpensNowText(opensNow: cafe.openNow),
        Spacer(),
        if (cafe.rating != null) Rating.large(cafe.rating),
      ],
    );
  }
}
