import 'package:coffee_time/presentation/app.dart';
import 'package:coffee_time/presentation/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'core/blocs/tabs/bloc.dart';
import 'models/app_tab.dart';
import 'screens/cafe_list/screen.dart';
import 'screens/favorites/screen.dart';
import 'screens/map/screen.dart';
import 'screens/settings/screen.dart';

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
    }
  }
}

class Shell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsBloc, AppTab>(
      builder: (context, tab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(ShellConfiguration.tabTitle(tab)),
          ),
          body: _mapTabToScreen(tab),
          bottomNavigationBar: _BottomTabSelector(
            currentTab: tab,
            tabSelected: (selectedTab) =>
                context.bloc<TabsBloc>().add(SetTab(selectedTab)),
          ),
        );
      },
    );
  }

  Widget _mapTabToScreen(AppTab currentTab) {
    switch (currentTab) {
      case AppTab.cafeList:
        return CafeListScreen();
        break;
      case AppTab.map:
        return MapScreen();
        break;
      case AppTab.favorites:
        return FavoritesScreen();
        break;
      case AppTab.settings:
        return SettingsScreen();
        break;
      default:
        return Center(
          child: Text('Unknown tab'),
        );
    }
  }
}

class _BottomTabSelector extends StatelessWidget {
  final AppTab currentTab;
  final Function(AppTab) tabSelected;

  _BottomTabSelector({
    @required this.currentTab,
    @required this.tabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: AppTab.values.indexOf(currentTab),
      items: AppTab.values
          .map(
            (t) => BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: Icon(ShellConfiguration.tabIcon(t)),
              title: Text(ShellConfiguration.tabTitle(t)),
            ),
          )
          .toList(),
      onTap: (index) => tabSelected(AppTab.values[index]),
    );
  }
}
