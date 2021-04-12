import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import '../entities/location.dart';
import '../exceptions/exceptions.dart';
import 'app_permission_provider.dart';

abstract class LocationService {
  Future<Location> getCurrentLocation();
  Stream<Location> getLocationStream({int distanceFilter = 10});
  double distanceBetween(Location start, Location end);
}

class GeolocatorLocationService implements LocationService {
  final Geolocator _geolocator;
  final AppPermissionProvider _locationPermissionProvider;

  StreamSubscription<Position> _geolocatorStream;
  StreamController<Location> _locationController;

  GeolocatorLocationService({
    @required Geolocator geolocator,
    @required AppPermissionProvider permissionProvider,
  })  : _geolocator = geolocator,
        _locationPermissionProvider = permissionProvider;

  Future<void> _checkAvailability() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw NoLocationServiceException();
    }

    final geoPermission = await Geolocator.checkPermission();

    if (geoPermission != LocationPermission.whileInUse) {
      //request again, but can fail if user opted 'ask never again'
      final permission = await _locationPermissionProvider.request();

      if (permission != Permission.locationAlways) {
        //if so throw exception
        throw NoLocationPermissionException(geoPermission);
      }
    }
  }

  @override
  Future<Location> getCurrentLocation() async {
    await _checkAvailability();

    final position = await Geolocator.getCurrentPosition();
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
    // final opt = LocationOptions(
    //   accuracy: LocationAccuracy.high,
    //   distanceFilter: distanceFilter,
    // );
    _geolocatorStream = Geolocator.getPositionStream(
            desiredAccuracy: LocationAccuracy.high,
            distanceFilter: distanceFilter)
        .listen(_locationChanged);
  }

  void _locationChanged(Position position) {
    _locationController?.add(Location(position.latitude, position.longitude));
  }

  void dispose() {
    _geolocatorStream?.cancel();
  }

  @override
  double distanceBetween(Location start, Location end) {
    return Geolocator.distanceBetween(start.lat, start.lng, end.lat, end.lng);
  }
}
