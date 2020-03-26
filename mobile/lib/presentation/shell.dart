import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/utils/string_utils.dart';
import 'core/blocs/filter/bloc.dart';
import 'core/blocs/tabs/bloc.dart';
import 'models/app_tab.dart';
import 'screens/cafe_list/bloc/bloc.dart' as cafe_list_bloc;
import 'screens/cafe_list/screen.dart';
import 'screens/favorites/screen.dart';
import 'screens/filter/screen.dart';
import 'screens/map/bloc/bloc.dart' as map_bloc;
import 'screens/map/screen.dart';
import 'shared/widgets/bottom_tab_selector.dart';
import 'shell_config.dart';

class Shell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<FilterBloc, FilterBlocState>(
      listener: (context, state) {
        if (state.confirmed) {
          context
              .bloc<map_bloc.MapBloc>()
              .add(map_bloc.FilterChanged(state.filter));
          context
              .bloc<cafe_list_bloc.CafeListBloc>()
              .add(cafe_list_bloc.Refresh(filter: state.filter));
        }
      },
      child: BlocBuilder<TabsBloc, AppTabKey>(
        builder: (context, tab) {
          return Scaffold(
            appBar: AppBar(
              title:
                  Text(ShellConfiguration.tabTitle(context, tab).capitalize()),
              actions: _mapTabToActions(context, tab),
            ),
            body: _mapTabToScreen(tab),
            bottomNavigationBar: BottomTabSelector(
              currentTab: tab,
              tabSelected: (selectedTab) =>
                  context.bloc<TabsBloc>().add(SetTab(selectedTab)),
            ),
          );
        },
      ),
    );
  }

  List<Widget> _mapTabToActions(BuildContext context, AppTabKey currentTab) {
    return [
      BlocBuilder<FilterBloc, FilterBlocState>(
        builder: (context, state) {
          final filter = state.filter;
          return IconButton(
            icon: Stack(children: [
              Icon(FontAwesomeIcons.filter),
              if (!filter.isDefault())
                Positioned(
                  right: 2,
                  bottom: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 8,
                      minHeight: 8,
                    ),
                  ),
                )
            ]),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    child: FilterScreen(),
                    value: context.bloc<FilterBloc>(),
                  ),
                ),
              );
            },
          );
        },
      )
    ];
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
      default:
        return Center(
          child: Text('Unknown tab'),
        );
    }
  }
}
