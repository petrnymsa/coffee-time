import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:flutter/foundation.dart';

class CafeModel extends CafeEntity {
  CafeModel({
    @required id,
    @required name,
    @required address,
    @required rating,
    @required openNow,
    @required location,
    @required photo,
    @required tags,
    @required isFavorite,
  }) : super(
          id: id,
          name: name,
          address: address,
          rating: rating,
          openNow: openNow,
          location: location,
          photo: photo,
          tags: tags,
          isFavorite: isFavorite,
        );

  factory CafeModel.fromJson(Map<String, dynamic> json) {
    return null; //todo implement
  }

  Map<String, dynamic> toJson() {
    return null; //todo implement
  }
}
