import 'package:flutter/material.dart';

import '../../../../domain/entities/cafe.dart';
import '../../../../domain/photo_url_helper.dart';
import 'tile_cover_image.dart';

class TileCoverContainer extends StatelessWidget {
  const TileCoverContainer({
    Key key,
    @required this.borderRadius,
    @required this.cafe,
  }) : super(key: key);

  final BorderRadius borderRadius;
  final Cafe cafe;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        LayoutBuilder(builder: (context, constraints) {
          return TileCoverImage(
            borderRadius: borderRadius,
            url: cafe.photos.isEmpty
                ? null
                : createPhotoUrl(
                    cafe.photos.first?.baseUrl,
                    maxHeight: constraints.maxHeight.ceil() * 2,
                  ),
          );
        }),
        Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
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
    );
  }
}
