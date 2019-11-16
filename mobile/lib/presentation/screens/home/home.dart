import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/presentation/providers/cafe_list.dart';
import 'package:coffee_time/presentation/screens/home/bottom_nav_bar.dart';
import 'package:coffee_time/presentation/screens/home/tabs/map_provider.dart';
import 'package:coffee_time/presentation/screens/home/tabs/tabs.dart';
import 'package:coffee_time/presentation/screens/home/tabs_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => TabsProvider(),
      child: Builder(
        builder: (ctx) => Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text('Kavárny v okolí'),
            actions: <Widget>[
              IconButton(
                onPressed: () async {
                  final result = await showSearch(
                      context: context, delegate: HomeSearchDelegate());
                  if (result != null)
                    Provider.of<CafeListProvider>(context, listen: false)
                        .refreshBySearch(result);
                },
                icon: Icon(Icons.search),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.list),
              )
            ],
          ),
          body: SafeArea(
            child: Container(
              child: Consumer<TabsProvider>(
                builder: (ctx, model, _) => _buildCurrentTab(context, model),
              ),
            ),
          ),
          bottomNavigationBar: HomeBottomNavigationBar(),
        ),
      ),
    );
  }

  Widget _buildCurrentTab(BuildContext context, TabsProvider model) {
    switch (model.currentTab) {
      case CurrentTab.CafeList:
        return CafeListTab();
        break;
      case CurrentTab.Map:
        return MapTab();
        break;
      case CurrentTab.Favorites:
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
