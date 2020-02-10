import 'dart:convert';

import 'package:equatable/equatable.dart';

class LocationModel extends Equatable {
  final double lat;
  final double lng;

  const LocationModel({
    this.lat,
    this.lng,
  });

  Map<String, dynamic> toMap() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  static LocationModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LocationModel(
      lat: map['lat'],
      lng: map['lng'],
    );
  }

  String toJson() => json.encode(toMap());

  static LocationModel fromJson(String source) => fromMap(json.decode(source));

  LocationModel copyWith({
    double lat,
    double lng,
  }) {
    return LocationModel(
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
    );
  }

  @override
  String toString() => 'LocationModel lat: $lat, lng: $lng';

  @override
  List<Object> get props => [lat, lng];
}
