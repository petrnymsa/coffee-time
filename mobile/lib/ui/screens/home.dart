import 'package:coffee_time/ui/screens/dummy.dart';
import 'package:coffee_time/ui/shared/hand_drawn_icons_icons.dart';
import 'package:coffee_time/ui/widgets/cafe_tile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('App'),
        leading: IconButton(
          icon: Icon(HandDrawnIcons.uniF1C3),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      body: Center(
        child: CafeTile(),
      ),
      drawer: Drawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(HandDrawnIcons.uniF14B), title: Text('Kavarny')),
          BottomNavigationBarItem(
              icon: Icon(HandDrawnIcons.uniF1C8), title: Text('Oblibene')),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(HandDrawnIcons.uniF1C5),
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => DummyScreen())),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
