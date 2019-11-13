import 'package:coffee_time/data/models/location.dart';
import 'package:coffee_time/data/models/photo.dart';
import 'package:coffee_time/data/models/tag.dart';
import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:flutter/foundation.dart';

class CafeModel extends CafeEntity {
  CafeModel({
    @required String id,
    @required String name,
    @required String address,
    @required double rating,
    @required bool openNow,
    @required LocationModel location,
    @required List<PhotoModel> photos,
    @required List<TagModel> tags,
    @required bool isFavorite,
  }) : super(
          id: id,
          name: name,
          address: address,
          rating: rating,
          openNow: openNow,
          location: location,
          photos: photos,
          tags: tags,
          isFavorite: isFavorite,
        );

  factory CafeModel.fromJson(Map<String, dynamic> json) {
    final photos = (json['photos'] as List<dynamic>)
            ?.map((m) => PhotoModel.fromJson(m))
            ?.toList() ??
        [];

    final tags = (json['tags'] as List<dynamic>)
            ?.map((m) => TagModel.fromJson(m))
            ?.toList() ??
        [];

    return CafeModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
      rating: json['rating'],
      openNow: json['opening_hours']['open_now'],
      location: LocationModel.fromJson(json['location']),
      photos: photos,
      tags: tags,
      isFavorite: true, //todo IsFavorite reading
    );
  }

  Map<String, dynamic> toJson() {
    return null; //todo implement
  }
}
