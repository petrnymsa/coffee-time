import 'dart:ui';
import 'dart:ui' as prefix0;

import 'package:coffee_time/ui/widgets/pricing.dart';
import 'package:coffee_time/ui/widgets/rating.dart';
import 'package:coffee_time/ui/widgets/tag.dart';
import 'package:flutter/material.dart';

class BlurredImage extends StatelessWidget {
  final ImageProvider image;

  BlurredImage(this.image);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: image,
          fit: BoxFit.cover,
        ),
      ),
      child: new BackdropFilter(
        filter: new ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
        child: new Container(
          decoration: new BoxDecoration(color: Colors.white.withOpacity(0.0)),
        ),
      ),
    );
  }
}

class CafeTile extends StatelessWidget {
  final Function onClick;

  CafeTile({Key key, this.onClick}) : super(key: key);

  void _onTileClick() {
    if (onClick != null) onClick();
  }

  @override
  Widget build(BuildContext context) {
    const borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(15),
      topRight: Radius.circular(15),
    );

    return GestureDetector(
      onTap: _onTileClick,
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 6.0,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: borderRadius,
                  child: BlurredImage(Image.network(
                    "https://www.dulwichpicturegallery.org.uk/media/10077/cafe-banner-min.jpg",
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ).image),
                ),
                Positioned(
                  top: 100,
                  right: 0,
                  child: Container(
                    color: Colors.black38,
                    child: Rating(4),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Center(
                    child: Text(
                      'Cafe Prostoru_',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
