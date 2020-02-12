import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/review.dart';

class ReviewModel extends Equatable {
  final String authorName;
  final String authorUrl;
  final String language;
  final String profilePhotoUrl;
  final int rating;
  final String relativeTimeDescription;
  final String text;
  final int time;
  ReviewModel({
    @required this.authorName,
    @required this.authorUrl,
    @required this.language,
    @required this.profilePhotoUrl,
    @required this.rating,
    @required this.relativeTimeDescription,
    @required this.text,
    @required this.time,
  });

  ReviewModel copyWith({
    String authorName,
    String authorUrl,
    String language,
    String profilePhotoUrl,
    int rating,
    String relativeTimeDescription,
    String text,
    int time,
  }) {
    return ReviewModel(
      authorName: authorName ?? this.authorName,
      authorUrl: authorUrl ?? this.authorUrl,
      language: language ?? this.language,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
      rating: rating ?? this.rating,
      relativeTimeDescription:
          relativeTimeDescription ?? this.relativeTimeDescription,
      text: text ?? this.text,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'author_name': authorName,
      'author_url': authorUrl,
      'language': language,
      'profile_photo_url': profilePhotoUrl,
      'rating': rating,
      'relative_time_description': relativeTimeDescription,
      'text': text,
      'time': time,
    };
  }

  static ReviewModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ReviewModel(
      authorName: map['author_name'],
      authorUrl: map['author_url'],
      language: map['language'],
      profilePhotoUrl: map['profile_photo_url'],
      rating: map['rating'],
      relativeTimeDescription: map['relative_time_description'],
      text: map['text'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  static ReviewModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'ReviewModel authorName: $authorName, authorUrl: $authorUrl, language: $language, profilePhotoUrl: $profilePhotoUrl, rating: $rating, relativeTimeDescription: $relativeTimeDescription, text: $text, time: $time';
  }

  @override
  List<Object> get props => [
        authorName,
        authorUrl,
        language,
        profilePhotoUrl,
        relativeTimeDescription,
        text,
        time
      ];

  Review toEntity() => Review(
        authorName: authorName,
        authorUrl: authorUrl,
        language: language,
        profilePhotoUrl: profilePhotoUrl,
        rating: rating,
        relativeTimeDescription: relativeTimeDescription,
        text: text,
        time: time,
      );
}
