import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../domain/entities/review.dart';
import '../../../../shared/shared_widgets.dart';

class ReviewTile extends StatelessWidget {
  final Review review;

  const ReviewTile({
    Key key,
    @required this.review,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: review.profilePhotoUrl,
              placeholder: (_, __) => const CircularLoader(),
              errorWidget: (_, __, ___) => const FaIcon(FontAwesomeIcons.user),
            ),
          ),
          backgroundColor: Theme.of(context).accentColor,
          foregroundColor: Colors.white,
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Expanded(
                  child: Text(
                    review.authorName,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                Rating.small(
                  review.rating.toDouble(),
                  displayRating: false,
                ),
              ],
            ),
            Text(
              review.relativeTimeDescription,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.w300,
                color: Colors.black87,
              ),
            ),
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            review.text,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
