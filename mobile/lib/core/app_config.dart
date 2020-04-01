import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

enum AppEnvironment { dev, prod }

class AppConfig {
  final String apiUrl;

  AppConfig({@required this.apiUrl});

  static Future<AppConfig> load(AppEnvironment env) async {
    env = env ?? AppEnvironment.dev;
    final envStr = env.toString().split('.').last;

    final configContent = await rootBundle.loadString(
      'assets/config/$envStr.json',
    );

    // decode our json
    final config = jsonDecode(configContent);

    return AppConfig(apiUrl: config['apiUrl']);
  }
}
