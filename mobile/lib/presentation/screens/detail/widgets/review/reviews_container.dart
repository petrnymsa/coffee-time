import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../domain/entities/cafe_detail.dart';
import '../../../../../generated/i18n.dart';
import '../../../../shared/shared_widgets.dart';
import 'review_list.dart';

class ReviewsContainer extends StatelessWidget {
  final CafeDetail detail;
  const ReviewsContainer({
    Key key,
    @required this.detail,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const Divider(),
        SectionHeader(
          icon: FontAwesomeIcons.comments,
          title: I18n.of(context).detail_reviewsTitle,
        ),
        ReviewList(reviews: detail.reviews),
        const SizedBox(height: 10),
      ],
    );
  }
}
