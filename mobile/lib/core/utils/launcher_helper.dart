import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/location.dart';

class UrlLauncherHelper {
  static Future _launch(String scheme) async {
    if (await canLaunch(scheme)) {
      return launch(scheme);
    }
  }

  static Future launchNavigationWithAddress(String address) async {
    final scheme = 'geo:0,0?q=$address';
    return _launch(scheme);
  }

  static Future launchNavigation(Location location) async {
    final scheme = 'geo:${location.lat},${location.lng}';
    return _launch(scheme);
  }

  static Future launchPhone(String phoneNumber) async {
    final scheme = 'tel:$phoneNumber';
    return _launch(scheme);
  }

  static Future launcUrl(String url) async {
    return _launch(url);
  }
}
