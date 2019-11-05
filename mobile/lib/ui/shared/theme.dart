// general theme setting

import 'package:flutter/material.dart';

class AppTheme {
  static const main_color = const Color(0xFFF2594B);
  static const secondary_color = const Color(0xFFF2836B);
  static const background_color = const Color(0xFFF7F7F7);

  static ThemeData apply(BuildContext context) {
    return ThemeData(
        primaryColor: main_color,
        accentColor: secondary_color,
        backgroundColor: background_color,
        scaffoldBackgroundColor: background_color,
        primaryIconTheme: IconThemeData(color: Colors.white),
        accentIconTheme: IconThemeData(color: Colors.white),
        iconTheme: IconThemeData(color: main_color),
        fontFamily: 'Raleway');
  }
}
