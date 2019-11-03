import 'package:coffee_time/utils/rating_stars_count.dart';
import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final max = 5;
  final double rating;

  Rating(this.rating);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    // final stars = List<Icon>.generate(
    //     this.rating, (i) => Icon(Icons.star, color: primaryColor)).toList();

    // int fullCount = rating.ceil();

    // stars.addAll(List<Icon>.generate(this.max - this.rating,
    //     (i) => Icon(Icons.star_border, color: primaryColor)));

    final ratingToStars = RatingStarsCount.fromRating(rating);

    final List<Icon> stars = List<Icon>.generate(
            ratingToStars.full, (i) => Icon(Icons.star, color: primaryColor))
        .toList();

    stars.addAll(List<Icon>.generate(ratingToStars.half,
        (i) => Icon(Icons.star_half, color: primaryColor)).toList());
    stars.addAll(List<Icon>.generate(ratingToStars.empty,
        (i) => Icon(Icons.star_border, color: primaryColor)).toList());
    return Container(
      child: Row(
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
