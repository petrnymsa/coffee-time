import 'package:coffee_time/ui/screens/home/bottom_nav_bar.dart';
import 'package:coffee_time/ui/screens/home/tabs/cafe_list.dart';
import 'package:coffee_time/ui/screens/home/tabs/favorites.dart';
import 'package:coffee_time/ui/screens/home/tabs/map.dart';

import 'package:coffee_time/ui/shared/main_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  HomeBottomNavigationBarTab _currentTab;

  @override
  void initState() {
    _currentTab = HomeBottomNavigationBarTab.CafeList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Kavárny v okolí'),
          // leading: IconButton(
          //   icon: Icon(HandDrawnIcons.uniF1C3),
          //   onPressed: () => _scaffoldKey.currentState.openDrawer(),
          // ),
        ),
        body: SafeArea(
          child: _buildCurrentTab(context),
        ),
        drawer: MainDrawer(),
        bottomNavigationBar: HomeBottomNavigationBar(
            defaultTab: _currentTab,
            onTabChange: (tab) {
              setState(() {
                _currentTab = tab;
              });
            }));
  }

  Widget _buildCurrentTab(BuildContext context) {
    switch (_currentTab) {
      case HomeBottomNavigationBarTab.CafeList:
        return CafeListTab();
        break;
      case HomeBottomNavigationBarTab.Map:
        return MapTab();
        break;
      case HomeBottomNavigationBarTab.Favorites:
        return FavoritesTab();
        break;
      default:
        return Center(
          child: Text('Unknown tab'),
        );
    }
  }
}
