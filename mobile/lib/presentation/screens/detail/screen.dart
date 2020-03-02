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
import 'bloc/detail_bloc_state.dart';
import 'widgets/detail_widgets.dart';

class DetailScreen extends StatelessWidget {
  final Logger logger = getLogger('DetailScreen');

  DetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<DetailBloc, DetailBlocState>(
      builder: (ctx, state) {
        return state.when(
          loading: () => CircularLoader(),
          failure: (message) => FailureMessage(
            message: message,
          ),
          loaded: _buildDetail,
        );
      },
    ));
  }

  Widget _buildDetail(Cafe cafe, CafeDetail detail) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              CarouselSlider(
                images: detail.photos.map((p) => p.url).toList(),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: CircleAvatar(
                  radius: 26,
                  child: IconButton(
                      iconSize: 36,
                      icon: Icon(cafe.isFavorite //todo isFavorite
                          ? Icons.favorite
                          : Icons.favorite_border),
                      onPressed: () {
                        //model.toggleFavorite();
                        // Provider.of<CafeListProvider>(context,
                        //         listen: false)
                        //     .refresh();
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
                ContactCard(contact: detail.contact),
                const SizedBox(height: 10.0),
                OpeningHoursContainer(openingHours: detail.openingHours),
                const SizedBox(height: 10.0),
                TagsContainer(
                  tags: cafe.tags, //todo obtain tags view model
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
                  itemBuilder: (_, i) => ReviewTile(review: detail.reviews[i]),
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
    );
  }
}
