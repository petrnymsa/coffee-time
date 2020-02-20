import 'dart:convert';

import 'package:coffee_time/domain/entities/tag.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/cafe.dart';
import 'location.dart';
import 'photo.dart';
import 'tag_reputation.dart';

class CafeModel extends Equatable {
  final String placeId;
  final String name;
  final LocationModel location;
  final String iconUrl;
  final double rating;
  final bool openNow;
  final String address;
  final List<TagReputationModel> tags;
  final PhotoModel photo;
  CafeModel({
    @required this.placeId,
    @required this.name,
    @required this.location,
    @required this.iconUrl,
    @required this.rating,
    @required this.openNow,
    @required this.address,
    @required this.tags,
    this.photo,
  });

  Map<String, dynamic> toMap() {
    return {
      'place_id': placeId,
      'name': name,
      'geometry': {'location': location.toMap()},
      'icon': iconUrl,
      'rating': rating,
      'opening_hours': {'open_now': openNow},
      'formatted_address': address,
      'tags': List<dynamic>.from(tags.map((x) => x.toMap())),
      'photos': [photo.toMap()],
    };
  }

  static CafeModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CafeModel(
      placeId: map['place_id'],
      name: map['name'],
      location: LocationModel.fromMap(map['geometry']['location']),
      iconUrl: map['icon'],
      rating: map['rating']?.toDouble(),
      openNow: map['opening_hours'] != null
          ? map['opening_hours']['open_now']
          : null,
      address: map['formatted_address'] != null
          ? map['formatted_address']
          : map['vicinity'],
      tags: List<TagReputationModel>.from(
          map['tags']?.map((x) => TagReputationModel.fromMap(x))),
      photo:
          PhotoModel.fromMap(map['photos'] != null ? map['photos'][0] : null),
    );
  }

  String toJson() => json.encode(toMap());

  static CafeModel fromJson(String source) => fromMap(json.decode(source));

  CafeModel copyWith({
    String placeId,
    String name,
    LocationModel location,
    String iconUrl,
    double rating,
    bool openNow,
    String address,
    List<TagReputationModel> tags,
    PhotoModel photo,
  }) {
    return CafeModel(
      placeId: placeId ?? this.placeId,
      name: name ?? this.name,
      location: location ?? this.location,
      iconUrl: iconUrl ?? this.iconUrl,
      rating: rating ?? this.rating,
      openNow: openNow ?? this.openNow,
      address: address ?? this.address,
      tags: tags ?? this.tags,
      photo: photo ?? this.photo,
    );
  }

  @override
  String toString() {
    return 'CafeModel placeId: $placeId, name: $name, location: $location, iconUrl: $iconUrl, rating: $rating, openNow: $openNow, address: $address, tags: $tags, photo: $photo';
  }

  @override
  List<Object> get props => [
        placeId,
        name,
        location,
        iconUrl,
        rating,
        openNow,
        address,
        tags,
        photo,
      ];

  Cafe toEntity(
          {@required bool isFavorite,
          @required List<Tag> allTags,
          @required String photoUrl}) =>
      Cafe(
        placeId: placeId,
        name: name,
        location: location.toEntity(),
        iconUrl: iconUrl,
        rating: rating,
        openNow: openNow,
        address: address,
        tags: tags
            .map((x) => x.toEntity(
                allTags.firstWhere((t) => t.id == x.id, orElse: () => null)))
            .toList(),
        photos: [photo?.toEntity(photoUrl)],
        isFavorite: isFavorite,
      );
}
