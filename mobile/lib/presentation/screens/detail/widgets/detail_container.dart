import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

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

  const DetailContainer({
    Key key,
    @required this.logger,
    @required this.cafe,
    @required this.detail,
  }) : super(key: key);

  final Logger logger;

  void _onShowMap() async {
    UrlLauncherHelper.launchNavigationWithAddress(cafe.address);
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
                  title: cafe.name,
                  address: cafe.address,
                  onShowMap: _onShowMap,
                ),
                Divider(),
                if (detail.contact.hasValues)
                  ContactCard(contact: detail.contact),
                const SizedBox(height: 10.0),
                OpeningHoursContainer(openingHours: detail.openingHours),
                const SizedBox(height: 10.0),
                TagsContainer(
                  tags: cafe.tags,
                  onEdit: () async {
                    // final result = await Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (_) => ChangeNotifierProvider.value(
                    //         value: model, child: TagEditScreen()),
                    //   ),
                    // );
                    // //      Provider.of<CafeListProvider>(context).refresh();
                    // model.loadDetail();
                    // print(result);
                  },
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
