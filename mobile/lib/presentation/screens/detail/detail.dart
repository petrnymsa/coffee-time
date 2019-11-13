import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/contact.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/models/opening_hour.dart';
import 'package:coffee_time/presentation/screens/detail/detail_provider.dart';
import 'package:coffee_time/presentation/screens/detail/widgets/carousel_slider.dart';
import 'package:coffee_time/presentation/screens/detail/widgets/comment_tile.dart';
import 'package:coffee_time/presentation/screens/detail/widgets/opening_hours_table.dart';
import 'package:coffee_time/presentation/screens/detail/widgets/section_header.dart';
import 'package:coffee_time/presentation/widgets/expandable_panel.dart';
import 'package:coffee_time/presentation/widgets/rating.dart';
import 'package:coffee_time/presentation/widgets/tag_container.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  DetailScreen({Key key}) : super(key: key);

  final Logger logger = getLogger('DetailScreen');

  @override
  Widget build(BuildContext context) {
    final cafeId = ModalRoute.of(context).settings.arguments;
    return ChangeNotifierProvider(
      builder: (_) => DetailProvider(cafeId: cafeId),
      child: Scaffold(
        body: Consumer<DetailProvider>(
          builder: (ctx, model, _) {
            if (model.state == ProviderState.busy)
              return Center(
                child: CircularProgressIndicator(),
              );

            final cafe = model.detail;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Stack(
                    children: [
                      CarouselSlider(
                        images: cafe.photos.map((p) => p.url).toList(),
                      ),
                      AppBar(
                        backgroundColor: Colors.transparent,
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10.0),
                    child: Column(
                      children: [
                        Row(
                          children: <Widget>[
                            _buildOpeningTime(context, cafe.openNow),
                            Spacer(),
                            Rating.large(cafe.rating),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        _CafeNameContainer(
                          title: cafe.name,
                          address: cafe.address,
                          onShowMap: () {
                            logger.i('Show map for ${cafe.name}');
                          },
                        ),
                        Divider(),
                        _ContactCard(contact: cafe.contact),
                        const SizedBox(height: 10.0),
                        _OpeningHoursContainer(),
                        Divider(),
                        _TagsContainer(
                          tags: cafe.tags,
                          onAddTag: () => logger.i('Add tag'),
                        ),
                        Divider(),
                        SectionHeader(
                          icon: FontAwesomeIcons.comments,
                          title: 'Hodnocení',
                          after: <Widget>[
                            FlatButton(
                              onPressed: () {},
                              child: FittedBox(
                                child: Text('Přidat hodnocení'),
                              ),
                            )
                          ],
                        ),
                        ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: cafe.comments.length,
                          itemBuilder: (_, i) =>
                              CommentTile(comment: cafe.comments[i]),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Text _buildOpeningTime(BuildContext context, bool opensNow) {
    //final closingTime = DateFormat.Hm().format(cafe.closing);
    return Text(
      opensNow ? 'Otevřeno' : 'Zavřeno',
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

  final List<TagEntity> tags;
  final Function onAddTag;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionHeader(
          icon: FontAwesomeIcons.tags,
          title: 'Štítky',
          after: [
            FlatButton(
              child: Text(tags.isNotEmpty ? 'Přidat štítek' : 'Přidat nový.'),
              //  textColor: Theme.of(context).primaryColor,
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
                    (tag) => TagContainer(title: tag.title, icon: tag.icon),
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
                  // textColor: Theme.of(context).accentColor,
                  onPressed: null,
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
  final ContactEntity contact;

  const _ContactCard({Key key, @required this.contact}) : super(key: key);

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
                      child: Text(contact.phone),
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
