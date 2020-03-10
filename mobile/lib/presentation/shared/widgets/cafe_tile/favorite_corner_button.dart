import 'package:flutter/material.dart';

import '../../../../domain/entities/cafe.dart';

class FavoriteCornerButton extends StatelessWidget {
  final Function onPressed;

  const FavoriteCornerButton({
    Key key,
    @required this.radius,
    @required this.cafe,
    @required this.onPressed,
  }) : super(key: key);

  final double radius;
  final Cafe cafe;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Container(
        padding: const EdgeInsets.only(left: 2.0, bottom: 2.0),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withAlpha(200),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(radius),
            topRight: Radius.circular(radius),
          ),
        ),
        child: IconButton(
          icon: Icon(
            cafe.isFavorite ? Icons.favorite : Icons.favorite_border,
            size: 30,
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }
}
