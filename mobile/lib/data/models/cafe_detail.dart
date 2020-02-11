import 'dart:convert';

import 'package:coffee_time/data/models/models.dart';
import 'package:coffee_time/data/models/opening_hours.dart';
import 'package:coffee_time/data/models/review.dart';
import 'package:equatable/equatable.dart';

class CafeDetailModel extends Equatable {
  final String formattedPhoneNumber;
  final String internationalPhoneNumber;
  final String url;
  final int utcOffset;
  final String website; //optional
  final List<ReviewModel> reviews;
  final List<PhotoModel> photos;
  final OpeningHoursModel openingHours;

  CafeDetailModel({
    this.formattedPhoneNumber,
    this.internationalPhoneNumber,
    this.url,
    this.utcOffset,
    this.website,
    this.reviews,
    this.photos,
    this.openingHours,
  });

  CafeDetailModel copyWith({
    String formattedPhoneNumber,
    String internationalPhoneNumber,
    String url,
    int utcOffset,
    String website,
    List<ReviewModel> reviews,
    List<PhotoModel> photos,
    OpeningHoursModel openingHours,
  }) {
    return CafeDetailModel(
      formattedPhoneNumber: formattedPhoneNumber ?? this.formattedPhoneNumber,
      internationalPhoneNumber:
          internationalPhoneNumber ?? this.internationalPhoneNumber,
      url: url ?? this.url,
      utcOffset: utcOffset ?? this.utcOffset,
      website: website ?? this.website,
      reviews: reviews ?? this.reviews,
      photos: photos ?? this.photos,
      openingHours: openingHours ?? this.openingHours,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'formatted_phone_number': formattedPhoneNumber,
      'international_phone_number': internationalPhoneNumber,
      'url': url,
      'utc_offset': utcOffset,
      'website': website,
      'reviews': List<dynamic>.from(reviews.map((x) => x.toMap())),
      'photos': List<dynamic>.from(photos.map((x) => x.toMap())),
      'opening_hours': openingHours.toMap(),
    };
  }

  static CafeDetailModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CafeDetailModel(
      formattedPhoneNumber: map['formatted_phone_number'],
      internationalPhoneNumber: map['international_phone_number'],
      url: map['url'],
      utcOffset: map['utc_offset'],
      website: map['website'],
      reviews: List<ReviewModel>.from(
          map['reviews']?.map((x) => ReviewModel.fromMap(x))),
      photos: List<PhotoModel>.from(
          map['photos']?.map((x) => PhotoModel.fromMap(x))),
      openingHours: OpeningHoursModel.fromMap(map['opening_hours']),
    );
  }

  String toJson() => json.encode(toMap());

  static CafeDetailModel fromJson(String source) =>
      fromMap(json.decode(source));

  @override
  String toString() {
    return 'CafeDetailModel formattedPhoneNumber: $formattedPhoneNumber, internationalPhoneNumber: $internationalPhoneNumber, url: $url, utcOffset: $utcOffset, website: $website, reviews: $reviews, photos: $photos, openingHours: $openingHours';
  }

  @override
  List<Object> get props => [
        formattedPhoneNumber,
        internationalPhoneNumber,
        url,
        utcOffset,
        website,
        reviews,
        photos,
        openingHours,
      ];
}
