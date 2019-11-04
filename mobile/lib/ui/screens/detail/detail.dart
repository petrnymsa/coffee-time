import 'package:coffee_time/models/cafe.dart';
import 'package:coffee_time/ui/widgets/tag_container.dart';
import 'package:coffee_time/ui/screens/detail/widgets/carousel_slider.dart';
import 'package:coffee_time/ui/widgets/rating.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final Cafe cafe;
  const DetailScreen({Key key, this.cafe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(cafe.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              CarouselSlider(images: [
                cafe.mainPhotoUrl,
                cafe.mainPhotoUrl,
                cafe.mainPhotoUrl,
              ]),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _buildOpeningTime(context),
                        Spacer(),
                        Rating.large(cafe.rating),
                      ],
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Stack(
                      children: <Widget>[
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: <Widget>[
                              SelectableText(
                                cafe.title,
                                style: Theme.of(context).textTheme.headline,
                              ),
                              SelectableText(
                                cafe.address,
                                style: Theme.of(context).textTheme.subhead,
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20),
                            child: IconButton(
                              icon: Icon(FontAwesomeIcons.locationArrow),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    _ContactCard(),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Container(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(FontAwesomeIcons.tags),
                            const SizedBox(
                              width: 16.0,
                            ),
                            Text(
                              'Štítky',
                              style: Theme.of(context).textTheme.headline,
                            ),
                            if (cafe.tags.isNotEmpty) Spacer(),
                            if (cafe.tags.isNotEmpty)
                              FlatButton(
                                child: Text('Přidat štítek'),
                                textColor: Theme.of(context).primaryColor,
                                onPressed: () {},
                              )
                          ]),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: cafe.tags.isEmpty
                          ? FlatButton(
                              onPressed: () {},
                              child: Text('Žádné štítky. Přidat nový.'),
                              textColor: Theme.of(context).primaryColor,
                            )
                          : Wrap(
                              alignment: WrapAlignment.start,
                              crossAxisAlignment: WrapCrossAlignment.start,
                              direction: Axis.horizontal,
                              spacing: 5.0,
                              runSpacing: 5.0,
                              children: cafe.tags
                                  .map(
                                    (tag) => TagContainer(
                                        title: tag.title,
                                        color: tag.color,
                                        icon: tag.icon),
                                  )
                                  .toList(),
                            ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Text _buildOpeningTime(BuildContext context) {
    final closingTime = DateFormat.Hm().format(cafe.closing);
    return Text(
      'Otevřeno do $closingTime',
      style: Theme.of(context)
          .textTheme
          .overline
          .copyWith(fontWeight: FontWeight.w300, fontSize: 16),
    );
  }
}

class _ContactCard extends StatelessWidget {
  const _ContactCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Row(
                children: <Widget>[
                  Icon(Icons.phone),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      child: Text("775 028 016"),
                      onTap: () async {
                        if (await canLaunch("tel:775028016")) {
                          await launch("tel:775028016");
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Icon(FontAwesomeIcons.globe),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: InkWell(
                      child: Text("www.cafe.prostoru.cz"),
                      onTap: () async {
                        if (await canLaunch("https://cafe.prostoru.cz")) {
                          print('launch web');
                          await launch("https://cafe.prostoru.cz");
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
