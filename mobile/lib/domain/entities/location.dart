import 'package:coffee_time/core/utils/distance_helper.dart';
import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final double lat;
  final double lng;

  LocationEntity(this.lat, this.lng);

  @override
  List<Object> get props => [lat, lng];

  LocationEntity copyWith({
    double lat,
    double lng,
  }) {
    return LocationEntity(
      lat ?? this.lat,
      lng ?? this.lng,
    );
  }

  double distance(LocationEntity other) {
    return DistanceHelper.getDistanceFromLatLonInKm(
        lat, lng, other.lat, other.lng);
  }
}
