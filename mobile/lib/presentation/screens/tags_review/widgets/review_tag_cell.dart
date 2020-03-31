import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/tag_review.dart';

class ReviewTagCell extends StatelessWidget {
  final TagReview tagToReview;
  final TagReviewKind reviewKind;

  final Function onTagReview;

  const ReviewTagCell({
    @required this.tagToReview,
    @required this.reviewKind,
    @required this.onTagReview,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
        child: IconButton(
      icon: FaIcon(_reviewIcon()),
      color: tagToReview.review == reviewKind
          ? Theme.of(context).primaryColor
          : Colors.grey,
      onPressed: onTagReview,
    ));
  }

  IconData _reviewIcon() {
    switch (reviewKind) {
      case TagReviewKind.like:
        return FontAwesomeIcons.thumbsUp;
      case TagReviewKind.dislike:
        return FontAwesomeIcons.thumbsDown;
      case TagReviewKind.none:
        return FontAwesomeIcons.minus;
      default:
        return FontAwesomeIcons.question;
    }
  }
}
