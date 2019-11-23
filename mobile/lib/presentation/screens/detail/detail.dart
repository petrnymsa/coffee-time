import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/core/utils/distance_helper.dart';
import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
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

  String getDistance(CafeEntity cafe, BuildContext context) {
    double distance =
        Provider.of<CafeListProvider>(context, listen: false).getDistance(cafe);
    return DistanceHelper.getFormattedDistanceFromKm(distance);
  }

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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            OpensNowText(opensNow: cafe.openNow),
                            Spacer(),
                            Rating.large(cafe.rating),
                          ],
                        ),
                        Text('Vzdálenost ${getDistance(cafe, context)}'),
                        const SizedBox(height: 20.0),
                        CafeNameContainer(
                          title: cafe.name,
                          address: cafe.address,
                          onShowMap: () async {
                            logger.i('Show map for ${cafe.name}');
                            if (await canLaunch(cafe.cafeUrl))
                              launch(cafe.cafeUrl);
                          },
                        ),
                        Divider(),
                        ContactCard(contact: cafe.contact),
                        const SizedBox(height: 10.0),
                        OpeningHoursContainer(),
                        const SizedBox(height: 10.0),
                        TagsContainer(
                          tags: cafe.tags,
                          onEdit: () async {
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
                        Center(
                          child: RaisedButton.icon(
                            onPressed: () async {
                              if (await canLaunch(cafe.cafeUrl))
                                launch(cafe.cafeUrl);
                              else
                                logger.w('Can\'t launch url ${cafe.cafeUrl}');
                            },
                            label: Text('Přidat hodnocení'),
                            icon: Icon(FontAwesomeIcons.comment),
                          ),
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
}
