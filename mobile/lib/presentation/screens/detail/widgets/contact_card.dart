import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../domain/entities/contact.dart';

class ContactCard extends StatelessWidget {
  final Contact contact;

  const ContactCard({Key key, @required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urlWithoutHttps = contact.website
        ?.replaceAll(RegExp('^https?://'), '')
        ?.replaceAll('www', '');

    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: () async {
                if (await canLaunch("tel:${contact.formattedPhone}")) {
                  await launch("tel:${contact.formattedPhone}");
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Row(
                  children: <Widget>[
                    if (contact.formattedPhone != null) Icon(Icons.phone),
                    if (contact.formattedPhone != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(
                          contact.formattedPhone,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                  ],
                ),
              ),
            ),
            if (contact.website != null)
              InkWell(
                onTap: () async {
                  if (await canLaunch(contact.website)) {
                    await launch(contact.website);
                  }
                },
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(FontAwesomeIcons.globe),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(urlWithoutHttps),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
