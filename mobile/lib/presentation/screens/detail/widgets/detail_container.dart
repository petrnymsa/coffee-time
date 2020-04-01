import 'package:flutter/material.dart';

import '../../../../core/utils/launcher_helper.dart';
import '../../../../domain/entities/cafe.dart';
import '../../../../domain/entities/cafe_detail.dart';
import 'cafe_name_container.dart';
import 'cafe_photos.dart';
import 'contact_card.dart';
import 'detail_header.dart';
import 'opening_hours_container.dart';
import 'review/reviews_container.dart';
import 'tags_container.dart';

class DetailContainer extends StatelessWidget {
  final Cafe cafe;
  final CafeDetail detail;

  final Function onTagsEdit;

  const DetailContainer({
    Key key,
    @required this.cafe,
    @required this.detail,
    this.onTagsEdit,
  }) : super(key: key);

  void _onShowMap() async {
    await UrlLauncherHelper.launchNavigationWithAddress(cafe.address);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          CafePhotos(photos: detail.photos),
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailHeader(cafe: cafe),
                const SizedBox(height: 20.0),
                CafeNameContainer(
                  cafe: cafe,
                  onShowMap: _onShowMap,
                ),
                Divider(),
                if (detail.contact.hasValues)
                  ContactCard(contact: detail.contact),
                const SizedBox(height: 10.0),
                if (detail.openingHours != null)
                  OpeningHoursContainer(openingHours: detail.openingHours),
                const SizedBox(height: 10.0),
                TagsContainer(
                  tags: cafe.tags,
                  onEdit: onTagsEdit,
                ),
                if (detail.reviews?.length != 0)
                  ReviewsContainer(detail: detail),
              ],
            ),
          )
        ],
      ),
    );
  }
}
