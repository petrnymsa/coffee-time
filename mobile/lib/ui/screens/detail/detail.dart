import 'package:coffee_time/models/cafe.dart';
import 'package:coffee_time/models/opening_hour.dart';
import 'package:coffee_time/models/tag.dart';
import 'package:coffee_time/ui/screens/detail/widgets/opening_hours_table.dart';
import 'package:coffee_time/ui/screens/detail/widgets/section_header.dart';
import 'package:coffee_time/ui/widgets/expandable_panel.dart';
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
              Hero(
                tag: cafe.id,
                child: CarouselSlider(images: [
                  cafe.mainPhotoUrl,
                  cafe.mainPhotoUrl,
                  cafe.mainPhotoUrl,
                ]),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
                child: Column(
                  children: [
                    Row(
                      children: <Widget>[
                        _buildOpeningTime(context),
                        Spacer(),
                        Rating.large(cafe.rating),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    _CafeNameContainer(
                      title: cafe.title,
                      address: cafe.address,
                      onShowMap: () {
                        print('Show map for ${cafe.title}');
                      },
                    ),
                    Divider(),
                    _ContactCard(),
                    const SizedBox(height: 10.0),
                    _OpeningHoursContainer(),
                    Divider(),
                    _TagsContainer(
                      tags: cafe.tags,
                      onAddTag: () => print('Add tag'),
                    ),
                    Divider(),
                    SizedBox(height: 10.0),
                    SectionHeader(
                      icon: FontAwesomeIcons.comments,
                      title: 'Hodnocení',
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

class _OpeningHoursContainer extends StatelessWidget {
  const _OpeningHoursContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      header: SectionHeader(
        icon: FontAwesomeIcons.clock,
        title: 'Otevírací doba',
      ),
      body: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(left: 40.0),
          child: OpeningHoursTable(
            openingHours: {
              1: const OpeningTime(
                  opening: const HourMinute(8, 0),
                  closing: const HourMinute(16, 0)),
              2: const OpeningTime(
                  opening: const HourMinute(8, 0),
                  closing: const HourMinute(16, 0)),
              3: const OpeningTime(
                  opening: const HourMinute(8, 0),
                  closing: const HourMinute(16, 0)),
              4: const OpeningTime(
                  opening: const HourMinute(8, 0),
                  closing: const HourMinute(16, 0)),
              5: const OpeningTime(
                  opening: const HourMinute(8, 0),
                  closing: const HourMinute(16, 0)),
              6: const OpeningTime(
                  opening: const HourMinute(8, 0),
                  closing: const HourMinute(16, 0)),
              7: null,
            },
          ),
        ),
      ),
    );
  }
}

class _TagsContainer extends StatelessWidget {
  const _TagsContainer({Key key, @required this.tags, this.onAddTag})
      : super(key: key);

  final List<Tag> tags;
  final Function onAddTag;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionHeader(
          icon: FontAwesomeIcons.tags,
          title: 'Štítky',
          after: [
            Spacer(),
            FlatButton(
              child: Text(tags.isNotEmpty
                  ? 'Přidat štítek'
                  : 'Žádné štítky. Přidat nový.'),
              textColor: Theme.of(context).primaryColor,
              onPressed: onAddTag,
            )
          ],
        ),
        if (tags.isNotEmpty)
          Align(
            alignment: Alignment.topLeft,
            child: Wrap(
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              direction: Axis.horizontal,
              spacing: 5.0,
              runSpacing: 5.0,
              children: tags
                  .map(
                    (tag) => TagContainer(
                        title: tag.title, color: tag.color, icon: tag.icon),
                  )
                  .toList(),
            ),
          ),
        if (tags.isNotEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: Row(
              children: <Widget>[
                Text('Štítky neodpovídají realitě?'),
                FlatButton(
                  child: Text(
                    'Navrhnout změnu',
                  ),
                  textColor: Theme.of(context).accentColor,
                  onPressed: () => print('Rate tags'),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CafeNameContainer extends StatelessWidget {
  const _CafeNameContainer(
      {Key key, @required this.title, @required this.address, this.onShowMap})
      : super(key: key);

  final String title;
  final String address;
  final Function onShowMap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SelectableText(
                title,
                style: Theme.of(context).textTheme.headline,
              ),
              SelectableText(
                address,
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
              onPressed: onShowMap,
            ),
          ),
        ),
      ],
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
