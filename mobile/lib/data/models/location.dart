import 'package:equatable/equatable.dart';

import '../../domain/entities/location.dart';

class LocationModel extends Equatable {
  final double lat;
  final double lng;

  const LocationModel({
    this.lat,
    this.lng,
  });

  Map<String, dynamic> toJson() {
    return {
      'lat': lat,
      'lng': lng,
    };
  }

  static LocationModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return LocationModel(
      lat: map['lat'],
      lng: map['lng'],
    );
  }

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

  Location toEntity() => Location(lat, lng);
}
