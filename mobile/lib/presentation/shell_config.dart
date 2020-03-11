import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../generated/i18n.dart';
import 'models/app_tab.dart';

class ShellConfiguration {
  static String tabTitle(BuildContext context, AppTabKey tab) {
    switch (tab) {
      case AppTabKey.cafeList:
        return I18n.of(context).tabs_cafes;
      case AppTabKey.favorites:
        return I18n.of(context).tabs_favorites;
      case AppTabKey.map:
        return I18n.of(context).tabs_map;
      case AppTabKey.settings:
        return I18n.of(context).tabs_settings;
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
