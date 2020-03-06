import 'package:flutter/material.dart';

import '../../../core/utils/rating_stars_count.dart';

class Rating extends StatelessWidget {
  final int max = 5;
  final double rating;
  final double iconSize;
  final bool displayRating;
  Rating(this.rating, {this.iconSize = 24.0, this.displayRating = true});

  factory Rating.large(double rating, {bool displayRating = true}) {
    return Rating(
      rating,
      iconSize: 28,
      displayRating: displayRating,
    );
  }

  factory Rating.small(double rating, {bool displayRating = true}) {
    return Rating(
      rating,
      iconSize: 16,
      displayRating: displayRating,
    );
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).accentColor;

    final ratingToStars = RatingStarsCount.fromRating(rating);

    final stars = List<Icon>.generate(
      ratingToStars.full,
      (i) => Icon(
        Icons.star,
        color: primaryColor,
        size: iconSize,
      ),
    ).toList();

    stars.addAll(List<Icon>.generate(
      ratingToStars.half,
      (i) => Icon(
        Icons.star_half,
        color: primaryColor,
        size: iconSize,
      ),
    ).toList());
    stars.addAll(List<Icon>.generate(
      ratingToStars.empty,
      (i) => Icon(
        Icons.star_border,
        color: primaryColor,
        size: iconSize,
      ),
    ).toList());

    return Container(
      child: Row(
        textBaseline: TextBaseline.alphabetic,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (displayRating)
            Text(
              rating.toStringAsPrecision(2),
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ...stars,
        ],
      ),
    );
  }
}
