// general theme setting

import 'package:flutter/material.dart';

class AppTheme {
  static const _brown = const Color(0xFFB98068);
  static const _light_brown = const Color(0xFFCA9F75);

  static ThemeData apply(BuildContext context) {
    return ThemeData(
        primaryColor: _brown,
        accentColor: _light_brown,
        primaryIconTheme: IconThemeData(color: Colors.white),
        accentIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: _brown),
        fontFamily: 'Raleway');
  }
}
