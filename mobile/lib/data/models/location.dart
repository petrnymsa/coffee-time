import 'package:coffee_time/domain/entities/location.dart';
import 'package:meta/meta.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    @required double lat,
    @required double lng,
  }) : super(lat, lng);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      lat: json['lat'].toDouble(),
      lng: json['lng'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'lng': lng};
  }
}
