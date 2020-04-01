import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../generated/i18n.dart';
import '../model/tag_review.dart';
import 'review_tag_cell.dart';

class ReviewsTable extends StatelessWidget {
  final List<TagReview> tagsToReview;
  final Function(String, TagReviewKind) onTagReview;

  const ReviewsTable({
    Key key,
    @required this.tagsToReview,
    @required this.onTagReview,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30.0),
      child: Table(
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        defaultColumnWidth: FlexColumnWidth(),
        columnWidths: {
          0: FlexColumnWidth(3),
          1: FlexColumnWidth(2),
          2: FlexColumnWidth(2),
        },
        children: [
          TableRow(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.black12)),
              ),
              children: [
                Container(),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Text(
                    I18n.of(context).reviews_true,
                    textAlign: TextAlign.center,
                  ),
                ),
                TableCell(
                  verticalAlignment: TableCellVerticalAlignment.top,
                  child: Text(
                    I18n.of(context).reviews_false,
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
          ...tagsToReview.map((tag) => buildTableRow(context, tag)).toList()
        ],
      ),
    );
  }

  TableRow buildTableRow(BuildContext context, TagReview tagToReview) {
    return TableRow(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12)),
      ),
      children: [
        TableCell(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FaIcon(tagToReview.tag.icon, size: 16),
              const SizedBox(width: 6.0),
              Text(
                tagToReview.tag.translatedTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
        ReviewTagCell(
          tagToReview: tagToReview,
          reviewKind: TagReviewKind.like,
          onTagReview: () =>
              onTagReview(tagToReview.tag.id, TagReviewKind.like),
        ),
        ReviewTagCell(
          tagToReview: tagToReview,
          reviewKind: TagReviewKind.dislike,
          onTagReview: () =>
              onTagReview(tagToReview.tag.id, TagReviewKind.dislike),
        ),
      ],
    );
  }
}
