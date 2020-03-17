import 'package:flutter/material.dart';

import '../../../../di_container.dart';
import '../../../../domain/entities/location.dart';
import '../../../../domain/services/location_service.dart';

class DistanceText extends StatelessWidget {
  final Location cafeLocation;

  const DistanceText({
    Key key,
    @required this.cafeLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _distance(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('${snapshot.data.toInt()} m');
        }

        return Container();
      },
    );
  }

  Future<double> _distance() async {
    final service = sl<LocationService>();
    final currentLocation = await service.getCurrentLocation();
    return service.distanceBetween(currentLocation, cafeLocation);
  }
}
