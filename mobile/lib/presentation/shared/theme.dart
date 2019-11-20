// general theme setting

import 'package:flutter/material.dart';

class AppTheme {
  static const main_color = const Color(0xFFF2594B);
  static const secondary_color = const Color(0xFFF2836B);
  static const background_color = const Color(0xFFF7F7F7);

  static Map<int, Color> primarySwatch = {
    50: Color.fromRGBO(242, 89, 75, .1),
    100: Color.fromRGBO(242, 89, 75, .2),
    200: Color.fromRGBO(242, 89, 75, .3),
    300: Color.fromRGBO(242, 89, 75, .4),
    400: Color.fromRGBO(242, 89, 75, .5),
    500: Color.fromRGBO(242, 89, 75, .6),
    600: Color.fromRGBO(242, 89, 75, .7),
    700: Color.fromRGBO(242, 89, 75, .8),
    800: Color.fromRGBO(242, 89, 75, .9),
    900: Color.fromRGBO(242, 89, 75, 1),
  };

  static ThemeData apply(BuildContext context) {
    return ThemeData(
      primaryColor: main_color,
      primarySwatch: MaterialColor(0xFFF2594B, primarySwatch),
      accentColor: secondary_color,
      backgroundColor: background_color,
      scaffoldBackgroundColor: background_color,
      primaryIconTheme: IconThemeData(color: main_color),
      accentIconTheme: IconThemeData(color: secondary_color),
      appBarTheme: Theme.of(context)
          .appBarTheme
          .copyWith(iconTheme: IconThemeData(color: Colors.white)),
      iconTheme: IconThemeData(color: main_color),
      buttonTheme: ButtonThemeData(
          buttonColor: main_color, textTheme: ButtonTextTheme.primary),
      buttonColor: main_color,
      fontFamily: 'Raleway',
    );
  }
}
