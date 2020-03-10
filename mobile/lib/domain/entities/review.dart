import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Review extends Equatable {
  final String authorName;
  final String authorUrl;
  final String language;
  final String profilePhotoUrl;
  final int rating;
  final String relativeTimeDescription;
  final String text;
  final int time;

  Review({
    @required this.authorName,
    @required this.authorUrl,
    @required this.language,
    @required this.profilePhotoUrl,
    @required this.rating,
    @required this.relativeTimeDescription,
    @required this.text,
    @required this.time,
  });

  Review copyWith({
    String authorName,
    String authorUrl,
    String language,
    String profilePhotoUrl,
    int rating,
    String relativeTimeDescription,
    String text,
    int time,
  }) {
    return Review(
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

  @override
  String toString() {
    return '''ReviewEntity authorName: $authorName, authorUrl: $authorUrl, language: $language, profilePhotoUrl: $profilePhotoUrl, rating: $rating, relativeTimeDescription: $relativeTimeDescription, text: $text, time: $time''';
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
}
