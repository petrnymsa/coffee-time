import 'package:coffee_time/presentation/screens/home/bottom_nav_bar.dart';
import 'package:coffee_time/presentation/screens/home/home_provider.dart';
import 'package:coffee_time/presentation/screens/home/tabs/tabs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    return ChangeNotifierProvider(
      builder: (_) => HomeProvider(),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text('Kavárny v okolí'),
        ),
        body: SafeArea(
          child: Container(child: _buildCurrentTab(context)),
        ),
        bottomNavigationBar: HomeBottomNavigationBar(
          defaultTab: _currentTab,
          onTabChange: (tab) {
            setState(() {
              _currentTab = tab;
            });
          },
        ),
      ),
    );
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
