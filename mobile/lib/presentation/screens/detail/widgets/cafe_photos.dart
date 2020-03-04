import 'package:flutter/material.dart';

import '../../../../domain/entities/photo.dart';
import 'carousel_slider.dart';

class CafePhotos extends StatelessWidget {
  final List<Photo> photos;
  const CafePhotos({Key key, @required this.photos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          images: photos.map((p) => p.url).toList(),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ],
    );
  }
}
