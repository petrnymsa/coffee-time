import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_indicator/page_indicator.dart';

import '../../../../core/firebase/authentication.dart';
import '../../../../di_container.dart';
import '../../../../domain/photo_url_helper.dart';
import '../../../shared/shared_widgets.dart';

class CarouselSlider extends StatefulWidget {
  final List<String> images;
  final double height;

  CarouselSlider({Key key, @required this.images, @required this.height})
      : assert(images != null),
        super(key: key);

  @override
  _CarouselSliderState createState() => _CarouselSliderState();
}

class _CarouselSliderState extends State<CarouselSlider> {
  @override
  Widget build(BuildContext context) {
    final items = widget.images;
    final theme = Theme.of(context);
    return Container(
      height: widget.height,
      child: PageIndicatorContainer(
        length: items.length,
        child: PageView.builder(
          itemCount: items.length,
          itemBuilder: (ctx, index) {
            //not ideal though - consider using top-level provider style
            return FutureBuilder<String>(
              future: sl<FirebaseAuthProvider>().getAuthToken(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return CachedNetworkImage(
                    fit: BoxFit.cover,
                    width: double.infinity,
                    imageUrl: items[index],
                    httpHeaders: createPhotoHttpHeader(snapshot.data),
                    placeholder: (_, __) => CircularLoader(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return Center(child: CircularLoader());
              },
            );
          },
        ),
        indicatorSelectorColor: theme.primaryColor,
      ),
    );
  }
}
