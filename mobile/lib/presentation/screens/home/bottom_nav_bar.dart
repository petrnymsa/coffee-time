import 'package:coffee_time/presentation/screens/home/tabs_provider.dart';
import 'package:coffee_time/presentation/shared/icons/hand_draw_icons_named.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TabsProvider>(
      builder: (ctx, model, _) => BottomNavigationBar(
        elevation: 5.0,
        currentIndex: model.currentTab.index,
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
          model.changeTab(CurrentTab.values[i]);
        },
      ),
    );
  }
}
