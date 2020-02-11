import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/contact.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/opening_hour.dart';
import 'package:coffee_time/domain/entities/photo.dart';
import 'package:coffee_time/domain/entities/review.dart';
import 'package:coffee_time/domain/entities/tag_reputation.dart';

class CafeDetail extends Cafe {
  final Contact contact;
  final String url;
  final int utcOffset;
  final OpeningHours openingHours;
  final List<Review> reviews;

  CafeDetail(
      {String placeId,
      String name,
      String address,
      double rating,
      bool isFavorite = false,
      Location location,
      List<PhotoEntity> photos,
      List<TagReputation> tags,
      this.contact,
      this.url,
      this.openingHours,
      this.utcOffset,
      this.reviews})
      : super(
            placeId: placeId,
            name: name,
            address: address,
            rating: rating,
            openNow: openingHours?.openNow,
            isFavorite: isFavorite,
            location: location,
            photos: photos,
            tags: tags);

  factory CafeDetail.fromCafe(Cafe entity,
      {Contact contact,
      String cafeUrl,
      int utcOffset,
      OpeningHours openingHours,
      List<Review> reviews,
      List<PhotoEntity> additionalPhotos}) {
    return CafeDetail(
        placeId: entity.placeId,
        name: entity.name,
        address: entity.address,
        rating: entity.rating,
        isFavorite: entity.isFavorite,
        location: entity.location,
        photos: [...entity.photos, ...additionalPhotos],
        tags: entity.tags,
        contact: contact,
        url: cafeUrl,
        reviews: reviews,
        utcOffset: utcOffset,
        openingHours: openingHours);
  }

  @override
  List<Object> get props => [...super.props, contact, url, reviews];
}
