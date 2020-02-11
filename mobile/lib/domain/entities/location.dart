import 'package:coffee_time/core/utils/distance_helper.dart';
import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final double lat;
  final double lng;

  Location(this.lat, this.lng);

  @override
  List<Object> get props => [lat, lng];

  Location copyWith({
    double lat,
    double lng,
  }) {
    return Location(
      lat ?? this.lat,
      lng ?? this.lng,
    );
  }

  double distance(Location other) {
    return DistanceHelper.getDistanceFromLatLonInKm(
        lat, lng, other.lat, other.lng);
  }
}
