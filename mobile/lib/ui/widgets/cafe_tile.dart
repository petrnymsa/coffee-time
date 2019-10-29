import 'dart:ui';

import 'package:coffee_time/ui/widgets/pricing.dart';
import 'package:coffee_time/ui/widgets/rating.dart';
import 'package:coffee_time/ui/widgets/tag.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    print('tile click');
    if (onClick != null) onClick();
  }

  @override
  Widget build(BuildContext context) {
    const tileHeight = 226.0;
    const imageHegiht = 120.0;
    const radius = 15.0;
    const borderRadius = const BorderRadius.only(
      topLeft: Radius.circular(radius),
      topRight: Radius.circular(radius),
    );

    const tileImageUrl =
        "https://static8.fotoskoda.cz/data/cache/thumb_700-392-24-0-1/articles/2317/1542705898/fotosoutez_prostor_ntk_cafe_prostoru_uvod.jpg";

    return GestureDetector(
      onTap: _onTileClick,
      child: SizedBox(
        height: tileHeight,
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
                  child: Image.network(
                    tileImageUrl,
                    height: imageHegiht,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // BlurredImage(Image.network(
                  //   "https://www.dulwichpicturegallery.org.uk/media/10077/cafe-banner-min.jpg",
                  //   height: 100,
                  //   width: double.infinity,
                  //   fit: BoxFit.cover,
                  // ).image),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.only(left: 2.0, bottom: 2.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius),
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () => print('Favorite'),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Container(
                    padding: const EdgeInsets.only(left: 2.0, bottom: 2.0),
                    decoration: BoxDecoration(
                      color: Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(radius),
                        topLeft: Radius.circular(radius),
                      ),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.map),
                      onPressed: () => print('Map'),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 4.0),
                      color: Colors.black87,
                      child: Text(
                        'Cafe Prostoru_',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 2.0),
                    height: tileHeight - imageHegiht - 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text(
                              'Technická 270/6',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            ),
                            Spacer(),
                            Rating(4),
                          ],
                        ),
                        // Align(
                        //   alignment: Alignment.centerRight,
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(right: 4.0),
                        //     child: Pricing(2),
                        //   ),
                        // ),
                        //Text('Zavírá ve 22:00'),
                        // SizedBox(
                        //   height: 16,
                        // ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0),
                          child: Text(
                            'Vzdálené 800 m',
                            style: prefix0.TextStyle(
                                color: Colors.grey, fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 2.0, top: 4.0),
                          child: Row(
                            children: <Widget>[
                              Tag(
                                'Wifi',
                                icon: Icons.wifi,
                                color: Colors.green,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: Tag(
                                  'Pivo',
                                  icon: FontAwesomeIcons.beer,
                                  color: Colors.amber,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 6.0),
                                child: Tag(
                                  'Venkovní terasa',
                                  icon: FontAwesomeIcons.umbrellaBeach,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
