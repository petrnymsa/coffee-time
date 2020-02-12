import 'cafe.dart';
import 'contact.dart';
import 'location.dart';
import 'opening_hour.dart';
import 'photo.dart';
import 'review.dart';
import 'tag_reputation.dart';

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
      List<Photo> photos,
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
      List<Photo> additionalPhotos}) {
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
