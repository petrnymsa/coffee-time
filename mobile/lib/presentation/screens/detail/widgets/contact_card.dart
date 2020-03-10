import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/utils/launcher_helper.dart';
import '../../../../domain/entities/contact.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;

  const ContactCard({Key key, @required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //  Spacer(),
            if (contact.formattedPhone != null)
              Phone(contact: contact),
            if (contact.website != null)
              Website(contact: contact),
            // Spacer(),
          ],
        ),
      ),
    );
  }
}

class Website extends StatelessWidget {
  const Website({
    Key key,
    @required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await UrlLauncherHelper.launcUrl(contact.website);
      },
      child: Container(
        padding: const EdgeInsets.only(left: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Icon(FontAwesomeIcons.globe),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Web page',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Phone extends StatelessWidget {
  const Phone({
    Key key,
    @required this.contact,
  }) : super(key: key);

  final Contact contact;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await UrlLauncherHelper.launchPhone(contact.internationalPhone);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Row(
          children: <Widget>[
            Icon(Icons.phone),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                contact.formattedPhone,
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
