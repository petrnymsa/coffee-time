import 'package:flutter/material.dart';

import '../../../../../domain/entities/cafe.dart';
import '../../../../../domain/entities/location.dart';
import 'bottom_line.dart';
import 'tags_row.dart';
import 'top_line.dart';

class BottomContainer extends StatelessWidget {
  const BottomContainer({
    Key key,
    @required this.tileHeight,
    @required this.imageHegiht,
    @required this.cafe,
    @required this.currentLocation,
  }) : super(key: key);

  final double tileHeight;
  final double imageHegiht;
  final Cafe cafe;
  final Location currentLocation;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        height: tileHeight - imageHegiht - 8,
        padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TopLine(cafe: cafe),
            BottomLine(cafe: cafe, currentLocation: currentLocation),
            if (cafe.tags.isNotEmpty) TagsRow(tags: cafe.tags),
          ],
        ),
      ),
    );
  }
}
