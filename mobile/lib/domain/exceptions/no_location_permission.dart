import 'package:geolocator/geolocator.dart';

class NoLocationPermissionException implements Exception {
  final GeolocationStatus status;

  const NoLocationPermissionException(this.status);
}
