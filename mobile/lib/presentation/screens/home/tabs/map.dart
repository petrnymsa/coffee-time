import 'package:coffee_time/core/app_logger.dart';
import 'package:flutter/material.dart';

class MapTab extends StatelessWidget {
  const MapTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getLogger('CafeListTab').i('Build');
    return Center(
      child: Text('Map'),
    );
  }
}
