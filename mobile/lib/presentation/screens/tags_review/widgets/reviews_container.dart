import 'package:coffee_time/presentation/screens/tags_review/model/tag_review.dart';
import 'package:flutter/material.dart';

import 'header_info.dart';
import 'reviews_table.dart';

class ReviewsContainer extends StatelessWidget {
  final List<TagReview> tagsToReview;
  final Function(String, TagReviewKind) onTagReview;

  const ReviewsContainer({
    Key key,
    @required this.tagsToReview,
    @required this.onTagReview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        HeaderInfo(),
        ReviewsTable(tagsToReview: tagsToReview, onTagReview: onTagReview)
      ],
    );
  }
}
