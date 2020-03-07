import 'dart:convert';

import 'package:equatable/equatable.dart';

import '../../domain/entities/photo.dart';

class PhotoModel extends Equatable {
  final int width;
  final int height;
  final String reference;
  PhotoModel({
    this.width,
    this.height,
    this.reference,
  });

  PhotoModel copyWith({
    int width,
    int height,
    String reference,
  }) {
    return PhotoModel(
      width: width ?? this.width,
      height: height ?? this.height,
      reference: reference ?? this.reference,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'width': width,
      'height': height,
      'photo_reference': reference,
    };
  }

  static PhotoModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PhotoModel(
      width: map['width'],
      height: map['height'],
      reference: map['photo_reference'],
    );
  }

  String toJson() => json.encode(toMap());

  static PhotoModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() =>
      'PhotoModel width: $width, height: $height, reference: $reference';

  @override
  List<Object> get props => [width, height, reference];

  Photo toEntity(String baseUrl) => Photo(
        maxHeight: height,
        maxWidth: width,
        baseUrl: baseUrl,
      );
}
