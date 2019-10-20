import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('App'),
        ),
        body: Center(
          child: Text('Flutter Demo Home Page'),
        ),
        drawer: Drawer(),
        bottomNavigationBar: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Kavarny')),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border), title: Text('Oblibene')),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.map),
          onPressed: () {},
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}
