import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../shared_widgets.dart';

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
              placeholder: (context, url) => CircularLoader(),
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
