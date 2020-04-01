import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../models/app_tab.dart';
import '../../shell_config.dart';
import '../theme.dart';

class BottomTabSelector extends StatelessWidget {
  final AppTabKey currentTab;
  final Function(AppTabKey) tabSelected;

  BottomTabSelector({
    @required this.currentTab,
    @required this.tabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppTabKey.values.indexOf(currentTab),
      type: BottomNavigationBarType.fixed,
      items: AppTabKey.values
          .map(
            (t) => BottomNavigationBarItem(
              backgroundColor: AppTheme.kMainColor,
              icon: FaIcon(ShellConfiguration.tabIcon(t)),
              title: Text(ShellConfiguration.tabTitle(context, t)),
            ),
          )
          .toList(),
      onTap: (index) => tabSelected(AppTabKey.values[index]),
    );
  }
}
