import 'dart:math';

class DistanceHelper {
  //todo can i use it?
  static double getDistanceFromLatLonInKm(
      double lat1, double lon1, double lat2, double lon2) {
    var R = 6371; // Radius of the earth in km
    var dLat = _deg2rad(lat2 - lat1); // deg2rad below
    var dLon = _deg2rad(lon2 - lon1);
    var a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_deg2rad(lat1)) *
            cos(_deg2rad(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);
    var c = 2 * atan2(sqrt(a), sqrt(1 - a));
    var d = R * c; // Distance in km
    return d;
  }

  static String getFormattedDistanceFromKm(double distance) {
    if (distance < 1) {
      return '${(distance * 1000).toInt()} m';
    } else {
      return '${distance.toStringAsFixed(2)} km';
    }
  }

  static double _deg2rad(deg) {
    return deg * (pi / 180);
  }
}
