import 'package:flutter/material.dart';

class MapTab extends StatelessWidget {
  const MapTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Build ${this.toStringShort()}');
    return Center(
      child: Text('Map'),
    );
  }
}
