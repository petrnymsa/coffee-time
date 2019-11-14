import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/presentation/screens/home/bottom_nav_bar.dart';
import 'package:coffee_time/presentation/screens/home/home_provider.dart';
import 'package:coffee_time/presentation/screens/home/tabs/tabs.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.list),
            ),
            IconButton(
              onPressed: () async {
                final result = await showSearch(
                    context: context, delegate: HomeSearchDelegate());
              },
              icon: Icon(Icons.search),
            )
          ],
        ),
        body: SafeArea(
          child: Container(child: _buildCurrentTab(context)),
        ),
        bottomNavigationBar: HomeBottomNavigationBar(
          defaultTab: _currentTab,
          onTabChange: (tab) {
            setState(() {
              _currentTab = tab; //todo very ugly
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

class HomeSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final addresses = InMemoryCafeRepository.instance.addresses
        .where((a) => a.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: addresses.length,
      itemBuilder: (_, i) => Text(addresses[i]),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.length < 2) return Container();

    final addresses = InMemoryCafeRepository.instance.addresses
        .where((a) => a.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Container(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: addresses.length,
        itemBuilder: (_, i) => GestureDetector(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
            child: Text(addresses[i]),
          ),
          onTap: () {
            close(context, addresses[i]);
          },
        ),
      ),
    );
  }
}
