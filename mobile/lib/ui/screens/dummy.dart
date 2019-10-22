import 'package:coffee_time/ui/shared/hand_drawn_icons_icons.dart';
import 'package:flutter/material.dart';

class DummyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
        textTheme: Theme.of(context).textTheme,
        title: Text(
          'Dummy',
          textAlign: TextAlign.center,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(HandDrawnIcons.uniF11E),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text("Dummy"),
      ),
    );
  }
}
