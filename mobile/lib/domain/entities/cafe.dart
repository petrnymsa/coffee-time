import 'package:equatable/equatable.dart';

import 'location.dart';
import 'photo.dart';
import 'tag_reputation.dart';

class Cafe extends Equatable {
  final String placeId;
  final String name;
  final Location location;
  final String iconUrl;
  final double rating;
  final int priceLevel;
  final bool openNow;
  final String address;
  final List<TagReputation> tags;
  final List<Photo> photos;

  final bool isFavorite;

  Cafe({
    this.placeId,
    this.name,
    this.location,
    this.iconUrl,
    this.rating,
    this.priceLevel,
    this.openNow,
    this.address,
    this.tags,
    this.photos,
    this.isFavorite,
  });

  Cafe copyWith({
    String placeId,
    String name,
    Location location,
    String iconUrl,
    double rating,
    int priceLevel,
    bool openNow,
    String address,
    List<TagReputation> tags,
    List<Photo> photos,
    bool isFavorite,
  }) {
    return Cafe(
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      location: location ?? this.location,
      iconUrl: iconUrl ?? this.iconUrl,
      rating: rating ?? this.rating,
      priceLevel: priceLevel ?? this.priceLevel,
      openNow: openNow ?? this.openNow,
      address: address ?? this.address,
      tags: tags ?? this.tags,
      photos: photos ?? this.photos,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  String toString() {
    return '''CafeEntity placeId: $placeId, name: $name, location: $location, iconUrl: $iconUrl, rating: $rating, priceLevel: $priceLevel, openNow: $openNow, address: $address, tags: $tags, photos: $photos, isFavorite: $isFavorite''';
  }

  @override
  List<Object> get props => [
        placeId,
        name,
        location,
        iconUrl,
        rating,
        priceLevel,
        openNow,
        address,
        tags,
        photos,
        isFavorite
      ];
}
