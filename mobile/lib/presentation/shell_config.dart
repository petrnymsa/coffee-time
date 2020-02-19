import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'models/app_tab.dart';

class ShellConfiguration {
  //todo maybe read from some .json config, translation config
  static String tabTitle(AppTab tab) {
    return tab.toString();
  }

  static IconData tabIcon(AppTab tab) {
    switch (tab) {
      case AppTab.cafeList:
        return FontAwesomeIcons.coffee;
      case AppTab.favorites:
        return FontAwesomeIcons.heart;
      case AppTab.map:
        return FontAwesomeIcons.map;
      case AppTab.settings:
        return FontAwesomeIcons.cog;
      default:
        return FontAwesomeIcons.question;
    }
  }
}
