import 'package:coffee_time/presentation/screens/home/home.dart';
import 'package:coffee_time/presentation/shared/theme.dart';
import 'package:flutter/material.dart';

// just some made up ideas
//todo layout helper (see ) - see https://www.youtube.com/watch?v=z7P1OFLw4kY
//todo add logger
//todo life cycle manager

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.apply(context),
      home: HomeScreen(),
    );
  }
}
