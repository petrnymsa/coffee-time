import 'package:coffee_time/utils/rating_stars_count.dart';
import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final max = 5;
  final double rating;
  final double iconSize;
  Rating(this.rating, {this.iconSize = 24.0});

  factory Rating.large(double rating) {
    return Rating(rating, iconSize: 28);
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).accentColor;

    final ratingToStars = RatingStarsCount.fromRating(rating);

    final List<Icon> stars = List<Icon>.generate(
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            rating.toStringAsPrecision(2),
            style: TextStyle(color: Colors.grey),
          ),
          ...stars,
        ],
      ),
    );
  }
}
