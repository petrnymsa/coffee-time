import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/launcher_helper.dart';

class AddReviewButton extends StatelessWidget {
  final String cafeUrl;
  const AddReviewButton({
    Key key,
    @required this.cafeUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton.icon(
        onPressed: () async {
          await UrlLauncherHelper.launcUrl(cafeUrl);
        },
        label: Text('Přidat hodnocení'),
        icon: Icon(FontAwesomeIcons.comment),
      ),
    );
  }
}
