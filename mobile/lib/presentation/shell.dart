import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/app_logger.dart';
import '../core/utils/string_utils.dart';
import '../di_container.dart';
import '../domain/entities/filter.dart';
import 'core/blocs/tabs/bloc.dart';
import 'models/app_tab.dart';
import 'screens/cafe_list/bloc/bloc.dart';
import 'screens/cafe_list/screen.dart';
import 'screens/favorites/bloc/bloc.dart' as favorites_bloc;
import 'screens/favorites/screen.dart';
import 'screens/filter/bloc/bloc.dart' as filter_bloc;
import 'screens/filter/screen.dart';
import 'screens/map/bloc/bloc.dart' as map_bloc;
import 'screens/map/screen.dart';
import 'shared/widgets/bottom_tab_selector.dart';
import 'shell_config.dart';

class Shell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabsBloc, AppTabKey>(
      builder: (context, tab) {
        return Scaffold(
          appBar: AppBar(
            title: Text(ShellConfiguration.tabTitle(context, tab).capitalize()),
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
    );
  }

  List<Widget> _mapTabToActions(BuildContext context, AppTabKey currentTab) {
    if (currentTab != AppTabKey.cafeList) return [];

    final cafeListBloc = context.bloc<CafeListBloc>();
    return [
      BlocBuilder<CafeListBloc, CafeListState>(
        builder: (context, state) {
          final filter =
              state.maybeMap(loaded: (l) => l.actualFilter, orElse: () => null);
          return IconButton(
            icon: Stack(children: [
              Icon(FontAwesomeIcons.filter),
              if (filter != null && filter != Filter())
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
              final filter = state.maybeMap(
                  loaded: (l) => l.actualFilter, orElse: () => null);

              final result = await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => BlocProvider(
                    create: (_) => filter_bloc.FilterBloc(
                      //todo DI
                      tagRepository: sl(),
                      initialFilter: filter,
                    )..add(filter_bloc.Init()),
                    child: FilterScreen(),
                  ),
                ),
              );

              if (result != null) {
                cafeListBloc.add(Refresh(filter: result));
              }
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
        return BlocProvider(
            create: (_) => sl<map_bloc.MapBloc>()..add(map_bloc.Init()),
            child: MapScreen());
        break;
      case AppTabKey.favorites:
        return BlocProvider(
            create: (_) =>
                sl<favorites_bloc.FavoritesBloc>()..add(favorites_bloc.Load()),
            child: FavoritesScreen());
        break;
      default:
        return Center(
          child: Text('Unknown tab'),
        );
    }
  }
}
