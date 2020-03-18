import 'package:flutter/material.dart';

import '../../../../generated/i18n.dart';
import '../model/tag_review.dart';
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
        Text(
          I18n.of(context).reviews_haederSubTitle,
          style: TextStyle(fontSize: 14, color: Colors.black54),
        ),
        ReviewsTable(tagsToReview: tagsToReview, onTagReview: onTagReview)
      ],
    );
  }
}
