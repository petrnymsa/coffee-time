import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'contact.dart';
import 'opening_hour.dart';
import 'photo.dart';
import 'review.dart';

class CafeDetail extends Equatable {
  final Contact contact;
  final String url;
  final int utcOffset;
  final OpeningHours openingHours;
  final List<Review> reviews;
  final List<Photo> photos;

  CafeDetail({
    @required this.contact,
    @required this.url,
    @required this.openingHours,
    @required this.utcOffset,
    @required this.photos,
    @required this.reviews,
  });

  @override
  List<Object> get props =>
      [contact, url, utcOffset, openingHours, reviews, photos];
}
