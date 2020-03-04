import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/utils/launcher_helper.dart';
import '../../../../domain/entities/cafe.dart';
import 'bottom/bottom_container.dart';
import 'favorite_corner_button.dart';
import 'navigation_button.dart';
import 'tile_cover_container.dart';

// todo text styles
// todo color styles

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
    if (onMapTap != null) {
      onMapTap();
      return;
    }
    await UrlLauncherHelper.launchNavigation(cafe.location);
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
    //getLogger('CafeTile ${cafe.placeId}').i('Build');

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
                    child: TileCoverContainer(
                      borderRadius: borderRadius,
                      cafe: cafe,
                    ),
                  ),
                  FavoriteCornerButton(
                    radius: radius,
                    cafe: cafe,
                    onPressed: _onFavoriteTap,
                  ),
                  NavigationButton(
                    radius: radius,
                    cafe: cafe,
                    onPressed: _onMapTap,
                  ),
                  BottomContainer(
                    tileHeight: tileHeight,
                    imageHegiht: imageHegiht,
                    cafe: cafe,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
