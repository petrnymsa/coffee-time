import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/utils/string_utils.dart';
import 'core/blocs/tabs/bloc.dart';
import 'models/app_tab.dart';
import 'screens/cafe_list/screen.dart';
import 'screens/favorites/screen.dart';
import 'screens/map/screen.dart';
import 'screens/settings/screen.dart';
import 'shared/widgets/bottom_tab_selector.dart';
import 'shell_config.dart';

class Shell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsBloc, AppTabKey>(
      builder: (context, tab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(ShellConfiguration.tabTitle(tab).capitalize()),
          ),
          body: _mapTabToScreen(tab),
          bottomNavigationBar: BottomTabSelector(
            currentTab: tab,
            tabSelected: (selectedTab) =>
                context.bloc<TabsBloc>().add(SetTab(selectedTab)),
          ),
        );
      },
    );
  }

  Widget _mapTabToScreen(AppTabKey currentTab) {
    switch (currentTab) {
      case AppTabKey.cafeList:
        return CafeListScreen();
        break;
      case AppTabKey.map:
        return MapScreen();
        break;
      case AppTabKey.favorites:
        return FavoritesScreen();
        break;
      case AppTabKey.settings:
        return SettingsScreen();
        break;
      default:
        return Center(
          child: Text('Unknown tab'),
        );
    }
  }
}
