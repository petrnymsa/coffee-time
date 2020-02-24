import 'package:flutter/material.dart';

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
      items: AppTabKey.values
          .map(
            (t) => BottomNavigationBarItem(
              backgroundColor: AppTheme.main_color,
              icon: Icon(ShellConfiguration.tabIcon(t)),
              title: Text(ShellConfiguration.tabTitle(t)),
            ),
          )
          .toList(),
      onTap: (index) => tabSelected(AppTabKey.values[index]),
    );
  }
}
