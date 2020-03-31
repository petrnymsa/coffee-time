import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

class NoLocationPermissionException extends Equatable implements Exception {
  final GeolocationStatus status;

  const NoLocationPermissionException(this.status);

  @override
  List<Object> get props => [status];

  @override
  bool get stringify => true;
}
