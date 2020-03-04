import 'package:flutter/material.dart';

import '../../../../../domain/entities/review.dart';
import 'review_tile.dart';

class ReviewList extends StatelessWidget {
  final List<Review> reviews;
  const ReviewList({
    Key key,
    @required this.reviews,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      primary: false,
      shrinkWrap: true,
      itemCount: reviews.length,
      itemBuilder: (_, i) => ReviewTile(review: reviews[i]),
    );
  }
}
