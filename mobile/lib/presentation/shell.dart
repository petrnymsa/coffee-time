import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<TabsBloc, AppTab>(
      builder: (context, tab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(ShellConfiguration.tabTitle(tab)),
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
