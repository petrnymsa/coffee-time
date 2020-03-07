import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/domain/photo_url_helper.dart';
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
          height: 200,
          images: photos
              .take(4)
              .map((p) => createPhotoUrl(
                    p.baseUrl,
                    maxHeight: 400,
                  ))
              .toList(),
        ),
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
      ],
    );
  }
}
