import 'package:coffee_time/ui/shared/icons/hand_draw_icons_named.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(20),
                height: 200,
                child: Placeholder(),
              ),
              Divider(),
              ListTile(
                leading: Icon(HandDrawnIconsNamed.Cafe),
                title: Text('Kavárny'),
              ),
              ListTile(
                leading: Icon(HandDrawnIconsNamed.HeartTwisted),
                title: Text('Oblíbené'),
                onTap: () => print('Menu:favorite'),
              ),
              Spacer(),
              Divider(),
              ListTile(
                leading: Icon(HandDrawnIconsNamed.Settings),
                title: Text('Nastavení'),
                onTap: () => print('Menu:settings'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
