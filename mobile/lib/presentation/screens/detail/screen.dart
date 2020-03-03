import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/app_logger.dart';
import '../../../domain/entities/cafe.dart';
import '../../../domain/entities/cafe_detail.dart';
import '../../shared/shared_widgets.dart';

import 'bloc/detail_bloc.dart';
import 'bloc/detail_bloc_event.dart';
import 'bloc/detail_bloc_state.dart';
import 'widgets/detail_widgets.dart';

class DetailScreen extends StatelessWidget {
  final Logger logger = getLogger('DetailScreen');

  DetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetailBloc, DetailBlocState>(
      builder: (ctx, state) {
        return state.when(
          loading: () => CircularLoader(),
          failure: (message) => FailureMessage(
            message: message,
          ),
          loaded: (cafe, detail) => _buildDetail(context, cafe, detail),
        );
      },
    );
  }

  Widget _buildDetail(BuildContext context, Cafe cafe, CafeDetail detail) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                CarouselSlider(
                  images: detail.photos.map((p) => p.url).toList(),
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ],
            ),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
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
                  //Text('Vzdálenost ${getDistance(null, context)}'),
                  const SizedBox(height: 20.0),
                  CafeNameContainer(
                    title: cafe.name,
                    address: cafe.address,
                    onShowMap: () async {
                      logger.i('Show map for $cafe');
                      if (await canLaunch(detail.url)) launch(detail.url);
                    },
                  ),
                  Divider(),
                  if (detail.contact.hasValues)
                    ContactCard(contact: detail.contact),
                  const SizedBox(height: 10.0),
                  OpeningHoursContainer(openingHours: detail.openingHours),
                  const SizedBox(height: 10.0),
                  TagsContainer(
                    tags: cafe.tags,
                    onEdit: () async {
                      // final result = await Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (_) => ChangeNotifierProvider.value(
                      //         value: model, child: TagEditScreen()),
                      //   ),
                      // );
                      // //      Provider.of<CafeListProvider>(context).refresh();
                      // model.loadDetail();
                      // print(result);
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
                    itemCount: detail.reviews.length,
                    itemBuilder: (_, i) =>
                        ReviewTile(review: detail.reviews[i]),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: RaisedButton.icon(
                      onPressed: () async {
                        if (await canLaunch(detail.url)) {
                          launch(detail.url);
                        } else {
                          logger.w('Can\'t launch url ${detail.url}');
                        }
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
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          cafe.isFavorite ? Icons.favorite : Icons.favorite_border,
          size: 32,
          color: Colors.white,
        ),
        onPressed: () {
          context.bloc<DetailBloc>().add(ToggleFavorite(cafe.placeId));
        },
      ),
    );
  }
}
