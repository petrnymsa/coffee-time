import 'package:coffee_time/domain/entities/contact.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactCard extends StatelessWidget {
  final ContactEntity contact;

  const ContactCard({Key key, @required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final urlWithoutHttps =
        contact.website?.replaceAll(new RegExp('^https?://'), 'www.');

    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.phone),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      child: Text(
                        contact.phone,
                        style: TextStyle(fontSize: 16),
                      ),
                      onTap: () async {
                        if (await canLaunch("tel:${contact.phone}")) {
                          await launch("tel:${contact.phone}");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (contact.website != null)
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.globe),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: InkWell(
                        child: Text(urlWithoutHttps),
                        onTap: () async {
                          if (await canLaunch(contact.website)) {
                            await launch(contact.website);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
