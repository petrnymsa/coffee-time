import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/domain/entities/contact.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/models/opening_hour.dart';
import 'package:coffee_time/presentation/providers/cafe_list.dart';
import 'package:coffee_time/presentation/screens/detail/detail_provider.dart';
import 'package:coffee_time/presentation/screens/detail/widgets/detail_widgets.dart';
import 'package:coffee_time/presentation/screens/tags/edit/tag_edit_screen.dart';
import 'package:coffee_time/presentation/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final Logger logger = getLogger('DetailScreen');

  DetailScreen({Key key}) : super(key: key);

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
                children: <Widget>[
                  Stack(
                    children: [
                      CarouselSlider(
                        images: cafe.photos.map((p) => p.url).toList(),
                      ),
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: CircleAvatar(
                          radius: 26,
                          child: IconButton(
                              iconSize: 36,
                              icon: Icon(cafe.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_border),
                              onPressed: () {
                                print('FAVORITE ');
                                model.toggleFavorite();
                                Provider.of<CafeListProvider>(context,
                                        listen: false)
                                    .refresh();
                              }),
                        ),
                      ),
                      AppBar(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
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
                          onShowMap: () async {
                            logger.i('Show map for ${cafe.name}');
                            if (await canLaunch(cafe.cafeUrl))
                              launch(cafe.cafeUrl);
                          },
                        ),
                        Divider(),
                        _ContactCard(contact: cafe.contact),
                        const SizedBox(height: 10.0),
                        _OpeningHoursContainer(),
                        // Divider(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        _TagsContainer(
                          tags: cafe.tags,
                          onAddTag: () async {
                            final result = await Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => ChangeNotifierProvider.value(
                                    value: model, child: TagEditScreen()),
                              ),
                            );
                            Provider.of<CafeListProvider>(context).refresh();
                            model.loadDetail();
                            print(result);
                          },
                        ),
                        Divider(),
                        SectionHeader(
                          icon: FontAwesomeIcons.comments,
                          title: 'Hodnocení',
                        ),
                        // * comments
                        ListView.builder(
                          padding: const EdgeInsets.only(top: 10),
                          primary: false,
                          shrinkWrap: true,
                          itemCount: cafe.comments.length,
                          itemBuilder: (_, i) =>
                              CommentTile(comment: cafe.comments[i]),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton.icon(
                          onPressed: () async {
                            if (await canLaunch(cafe.cafeUrl))
                              launch(cafe.cafeUrl);
                            else
                              logger.w('Can\'t launch url ${cafe.cafeUrl}');
                          },
                          label: Text('Přidat hodnocení'),
                          icon: Icon(FontAwesomeIcons.comment),
                        ),
                        SizedBox(
                          height: 10,
                        ),
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

class _CafeNameContainer extends StatelessWidget {
  final String title;

  final String address;
  final Function onShowMap;
  const _CafeNameContainer(
      {Key key, @required this.title, @required this.address, this.onShowMap})
      : super(key: key);

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

class _OpeningHoursContainer extends StatelessWidget {
  const _OpeningHoursContainer({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpandablePanel(
      expanded: true,
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
  final List<TagEntity> tags;

  final Function onAddTag;
  const _TagsContainer({Key key, @required this.tags, this.onAddTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SectionHeader(
          icon: FontAwesomeIcons.tags,
          title: 'Štítky',
        ),
        if (tags.isEmpty)
          Padding(
            padding: EdgeInsets.all(4.0),
            child: Text('Žádné štítky prozatím nepřidány.'),
          ),
        if (tags.isNotEmpty)
          SizedBox(
            height: 20.0,
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
        FlatButton.icon(
          label: Text(
            'Navrhnout změnu',
            style: TextStyle(fontSize: 14),
          ),
          icon: Icon(
            FontAwesomeIcons.edit,
            size: 16,
          ),
          onPressed: onAddTag,
        )
        // Align(
        //   alignment: Alignment.centerRight,
        //   child: Row(
        //     children: <Widget>[
        //       Text('Štítky neodpovídají realitě?'),
        //       FlatButton(
        //         child: Text(
        //           'Navrhnout změnu',
        //         ),
        //         // textColor: Theme.of(context).accentColor,
        //         onPressed: null,
        //       ),
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
