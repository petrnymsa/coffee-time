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

  @override
  String toString() {
    return '$lat,$lng';
  }
}
