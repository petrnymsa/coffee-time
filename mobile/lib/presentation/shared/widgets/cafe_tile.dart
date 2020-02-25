import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/app_logger.dart';
import '../../../domain/entities/cafe.dart';
import '../../../domain/entities/tag_reputation.dart';
import 'rating.dart';
import 'tag/tag_widgets.dart';

// todo text styles
// todo color styles

//todo REFACTOR to smaller, self contained widgets

class CafeTile extends StatelessWidget {
  final Cafe cafe;
  final Function onTap;
  final Function onFavoriteTap;
  final Function onMapTap;

  CafeTile({
    Key key,
    @required this.cafe,
    this.onTap,
    this.onFavoriteTap,
    this.onMapTap,
  }) : super(key: key);

  void _onTileTap() {
    if (onTap != null) onTap();
  }

  void _onFavoriteTap() {
    if (onFavoriteTap != null) onFavoriteTap();
  }

  void _onMapTap(Cafe cafe) async {
    if (onMapTap != null) onMapTap();
    //final scheme = 'geo:${loc.lat},${loc.lng}';

    final scheme = 'geo:0,0?q=${cafe.address}';
    if (await canLaunch(scheme)) launch(scheme);
  }

  @override
  Widget build(BuildContext context) {
    const imageHegiht = 120.0;
    const radius = 8.0;
    const borderRadius = BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );
    final tileHeight = cafe.tags.isNotEmpty ? 216.0 : 180.0;
    // getLogger('CafeTile ${cafe.name}').i('Build');

    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: Theme.of(context).iconTheme.copyWith(color: Colors.white),
      ),
      child: GestureDetector(
        onTap: _onTileTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Container(
            height: tileHeight,
            child: Card(
              elevation: 6.0,
              shape: RoundedRectangleBorder(
                borderRadius: borderRadius,
              ),
              child: Stack(
                children: [
                  Container(
                    height: imageHegiht,
                    child: Stack(
                      children: <Widget>[
                        TileCoverImage(
                          borderRadius: borderRadius,
                          url: cafe.photos.first?.url,
                        ),
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 6.0, vertical: 4.0),
                            color: Colors.black87,
                            child: Text(
                              cafe.name,
                              style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Amatic',
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      padding: const EdgeInsets.only(left: 2.0, bottom: 2.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor.withAlpha(200),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radius),
                          topRight: Radius.circular(radius),
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          cafe.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 30,
                        ),
                        onPressed: _onFavoriteTap,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.only(left: 2.0, bottom: 2.0),
                      decoration: BoxDecoration(
                        color: Theme.of(context).accentColor.withAlpha(200),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(radius),
                          topLeft: Radius.circular(radius),
                        ),
                      ),
                      child: IconButton(
                        icon: Icon(
                          FontAwesomeIcons.locationArrow,
                          size: 24,
                        ),
                        onPressed: () => _onMapTap(cafe),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      height: tileHeight - imageHegiht - 8,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4.0, vertical: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 10, //! how?
                                // fit: FlexFit.tight,
                                child: Container(
                                  child: Text(
                                    cafe.address,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              if (cafe.rating != null) Rating(cafe.rating),
                            ],
                          ),
                          //  _buildClosing(context, cafe.openNow),
                          Row(
                            children: <Widget>[
                              //todo distance
                              // Text(
                              //     "Vzdálenost ${DistanceHelper.getFormattedDistanceFromKm(Provider.of<CafeListProvider>(context, listen: false).getDistance(cafe))}"),
                              Spacer(),
                              Text(
                                cafe.openNow != null && cafe.openNow
                                    ? 'Otevřeno'
                                    : 'Zavřeno',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300),
                              ),
                            ],
                          ),
                          // Align(
                          //   alignment: Alignment.topLeft,
                          //   child: Text("Vzdalenost 500m"),
                          // ),
                          if (cafe.tags.isNotEmpty)
                            _buildTags(cafe.tags),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClosing(BuildContext context, bool openNow) {
    return Align(
      alignment: Alignment.centerRight,
      child: Text(
        openNow ? 'Otevřeno' : 'Zavřeno',
        style: TextStyle(
            color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w300),
      ),
    );
  }

  Widget _buildTags(List<TagReputation> tags) {
    return Padding(
      padding: const EdgeInsets.only(left: 2.0, top: 8.0),
      child: Row(
        children: tags
            .map((t) => Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: TagContainer(icon: t.tag.icon),
                ))
            .toList(),
      ),
    );
  }
}

class TileCoverImage extends StatelessWidget {
  const TileCoverImage({
    Key key,
    @required this.borderRadius,
    @required this.url,
  }) : super(key: key);

  final BorderRadius borderRadius;
  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius,
      child: url != null
          ? CachedNetworkImage(
              imageUrl: url,
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
              width: double.infinity,
              fit: BoxFit.cover,
            )
          : Image.asset(
              'assets/table.jpg',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
    );
  }
}
