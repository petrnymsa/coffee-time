import 'package:coffee_time/presentation/shared/icons/hand_draw_icons_named.dart';
import 'package:flutter/material.dart';

enum HomeBottomNavigationBarTab { CafeList, Map, Favorites, Settings }

class HomeBottomNavigationBar extends StatefulWidget {
  final Function(HomeBottomNavigationBarTab) onTabChange;
  final HomeBottomNavigationBarTab defaultTab;

  HomeBottomNavigationBar(
      {Key key,
      this.onTabChange,
      this.defaultTab = HomeBottomNavigationBarTab.CafeList})
      : super(key: key);

  @override
  _HomeBottomNavigationBarState createState() =>
      _HomeBottomNavigationBarState();
}

class _HomeBottomNavigationBarState extends State<HomeBottomNavigationBar> {
  int _index = 0;

  @override
  void initState() {
    _index = HomeBottomNavigationBarTab.values.indexOf(widget.defaultTab);
    super.initState();
  }

  void _notifyTabChange() {
    if (widget.onTabChange != null) widget.onTabChange(current);
  }

  HomeBottomNavigationBarTab get current =>
      HomeBottomNavigationBarTab.values[_index];

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      elevation: 5.0,
      currentIndex: _index,
      selectedItemColor: Theme.of(context).primaryColor,
      unselectedItemColor: Colors.black,
      type: BottomNavigationBarType.shifting,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(HandDrawnIconsNamed.Cafe), title: Text('Kavarny')),
        BottomNavigationBarItem(
            icon: Icon(HandDrawnIconsNamed.MapMarker), title: Text('Mapa')),
        BottomNavigationBarItem(
          icon: Icon(HandDrawnIconsNamed.HeartTwisted),
          title: Text('Oblibene'),
        ),
        BottomNavigationBarItem(
          icon: Icon(HandDrawnIconsNamed.Settings),
          title: Text('Nastavení'),
        ),
      ],
      onTap: (i) {
        setState(() {
          _index = i;
        });

        _notifyTabChange();
      },
    );
  }
}
