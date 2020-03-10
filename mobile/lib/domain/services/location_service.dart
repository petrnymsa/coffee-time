import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

import '../entities/location.dart';

abstract class LocationService {
  Future<Location> getCurrentLocation();
  Stream<Location> getLocationStream({int distanceFilter = 10});
  Future<double> distanceBetween(Location start, Location end);
}

//todo check permission
class GeolocatorLocationService implements LocationService {
  final Geolocator _geolocator;

  StreamSubscription<Position> _geolocatorStream;
  StreamController<Location> _locationController;

  GeolocatorLocationService({@required Geolocator geolocator})
      : _geolocator = geolocator;

  @override
  Future<Location> getCurrentLocation() async {
    final position = await _geolocator.getCurrentPosition();
    return Location(position.latitude, position.longitude);
  }

  @override
  Stream<Location> getLocationStream({int distanceFilter = 10}) {
    _locationController = StreamController<Location>(
        onListen: () => _startListen(distanceFilter),
        onPause: () => _geolocatorStream?.pause(),
        onResume: () => _geolocatorStream?.resume(),
        onCancel: () => _geolocatorStream?.cancel());

    return _locationController.stream;
  }

  void _startListen(int distanceFilter) {
    final opt = LocationOptions(
      accuracy: LocationAccuracy.high,
      distanceFilter: distanceFilter,
    );
    _geolocatorStream =
        _geolocator.getPositionStream(opt).listen(_locationChanged);
  }

  void _locationChanged(Position position) {
    _locationController?.add(Location(position.latitude, position.longitude));
  }

  void dispose() {
    _geolocatorStream?.cancel();
  }

  @override
  Future<double> distanceBetween(Location start, Location end) {
    return _geolocator.distanceBetween(start.lat, start.lng, end.lat, end.lng);
  }
}
