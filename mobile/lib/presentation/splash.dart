import 'package:flutter/material.dart';

import 'shared/shared_widgets.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: CircularLoader());
  }
}
