import 'package:coffee_time/core/utils/launcher_helper.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

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
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if (contact.formattedPhone != null) Phone(contact: contact),
            if (contact.website != null) Website(contact: contact),
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
    return Expanded(
      child: InkWell(
        onTap: () async {
          // if (await canLaunch(contact.website)) {
          //   await launch(contact.website);
          // }
          await UrlLauncherHelper.launcUrl(contact.website);
        },
        child: Container(
          padding: const EdgeInsets.only(left: 5),
          child: Row(
            children: <Widget>[
              Icon(FontAwesomeIcons.globe),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    contact.websiteWithoutProtocol,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
              ),
            ],
          ),
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
        // if (await canLaunch("tel:${contact.internationalPhone}")) {
        //   await launch("tel:${contact.internationalPhone}");
        // }
        await UrlLauncherHelper.launchPhone(contact.internationalPhone);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 2.0),
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
