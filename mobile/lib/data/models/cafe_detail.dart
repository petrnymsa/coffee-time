import 'package:coffee_time/domain/entities/cafe_detail.dart';

import './contact.dart';
import './location.dart';
import './photo.dart';
import './tag.dart';
import './comment.dart';

class CafeDetailModel extends CafeDetailEntity {
  CafeDetailModel(
      {String id,
      String name,
      String address,
      double rating,
      bool openNow,
      bool isFavorite = false,
      LocationModel location,
      List<PhotoModel> photos,
      List<TagModel> tags,
      ContactModel contact,
      String cafeUrl,
      List<CommentModel> comments})
      : super(
          id: id,
          name: name,
          address: address,
          rating: rating,
          openNow: openNow,
          isFavorite: isFavorite,
          location: location,
          photos: photos,
          tags: tags,
          contact: contact,
          cafeUrl: cafeUrl,
          comments: comments,
        );

  factory CafeDetailModel.fromJson(Map<String, dynamic> json) {
    final photos = (json['photos'] as List<dynamic>)
            ?.map((m) => PhotoModel.fromJson(m))
            ?.toList() ??
        [];

    final tags = (json['tags'] as List<dynamic>)
            ?.map((m) => TagModel.fromJson(m))
            ?.toList() ??
        [];

    final reviews = (json['reviews'] as List<dynamic>)
            ?.map((m) => CommentModel.fromJson(m))
            ?.toList() ??
        [];
    final model = CafeDetailModel(
      id: json['place_id'],
      name: json['name'],
      address: json['address'],
      rating: json['rating'],
      openNow: json['opening_hours']['open_now'],
      location: LocationModel.fromJson(json['location']),
      photos: photos,
      tags: tags,
      isFavorite: false, //todo IsFavorite reading,
      contact: ContactModel(
          address: json['address'],
          website: json['website'],
          phone: json['formatted_phone_number']),
      cafeUrl: json['url'],
      comments: reviews,
    );
    return model;
  }

  Map<String, dynamic> toJson() {
    return null;
  }
}
