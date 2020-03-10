import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'models/app_tab.dart';

class ShellConfiguration {
  //todo maybe read from some .json config, translation config
  static String tabTitle(AppTabKey tab) {
    switch (tab) {
      case AppTabKey.cafeList:
        return 'cafes';
      case AppTabKey.favorites:
        return 'favorites';
      case AppTabKey.map:
        return 'map';
      case AppTabKey.settings:
        return 'settings';
      default:
        return 'unknown';
    }
  }

  static IconData tabIcon(AppTabKey tab) {
    switch (tab) {
      case AppTabKey.cafeList:
        return FontAwesomeIcons.coffee;
      case AppTabKey.favorites:
        return FontAwesomeIcons.heart;
      case AppTabKey.map:
        return FontAwesomeIcons.map;
      case AppTabKey.settings:
        return FontAwesomeIcons.cog;
      default:
        return FontAwesomeIcons.question;
    }
  }
}
