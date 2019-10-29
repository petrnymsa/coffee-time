import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final max = 5;
  final rating;

  Rating(this.rating);

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    final stars = List<Icon>.generate(
        this.rating, (i) => Icon(Icons.star, color: primaryColor)).toList();

    stars.addAll(List<Icon>.generate(this.max - this.rating,
        (i) => Icon(Icons.star_border, color: primaryColor)));

    return Container(
      child: Row(
        children: stars,
      ),
    );
  }
}
