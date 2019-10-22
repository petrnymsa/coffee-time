import 'package:coffee_time/ui/screens/home.dart';
import 'package:coffee_time/ui/shared/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.theme,
      home: HomeScreen(),
    );
  }
}
