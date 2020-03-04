import 'package:flutter/material.dart';

import '../../../../domain/entities/cafe.dart';
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
        TileCoverImage(
          borderRadius: borderRadius,
          url: cafe.photos.first?.url,
        ),
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
