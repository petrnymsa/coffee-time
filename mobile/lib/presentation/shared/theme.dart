// general theme setting

import 'package:flutter/material.dart';

//ignore_for_file: avoid_classes_with_only_static_members
class AppTheme {
  static const kMainColor = Color(0xFFF2594B);
  static const kSecondaryColor = Color(0xFFF2836B);
  static const kBackgroundColor = Color(0xFFF7F7F7);
  static const kTagColor = Color(0xFF63A69F);

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
      primaryColor: kMainColor,
      primarySwatch: MaterialColor(0xFFF2594B, primarySwatch),
      accentColor: kSecondaryColor,
      backgroundColor: kBackgroundColor,
      scaffoldBackgroundColor: kBackgroundColor,
      primaryIconTheme: IconThemeData(color: kMainColor),
      accentIconTheme: IconThemeData(color: kSecondaryColor),
      appBarTheme: Theme.of(context)
          .appBarTheme
          .copyWith(iconTheme: IconThemeData(color: Colors.white)),
      iconTheme: IconThemeData(color: kMainColor),
      buttonTheme: ButtonThemeData(
          buttonColor: kMainColor, textTheme: ButtonTextTheme.primary),
      buttonColor: kMainColor,
      fontFamily: 'Raleway',
    );
  }
}
