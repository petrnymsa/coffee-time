import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../di_container.dart';
import '../../../../../domain/entities/cafe.dart';
import '../../../../../domain/entities/location.dart';
import '../../../../../domain/services/location_service.dart';
import '../../../../../generated/i18n.dart';

class BottomLine extends StatelessWidget {
  final Cafe cafe;
  final Location currentLocation;

  const BottomLine({
    Key key,
    @required this.cafe,
    @required this.currentLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Spacer(),
        Icon(
          FontAwesomeIcons.walking,
          size: 14,
          color: Theme.of(context).accentColor,
        ),
        FutureBuilder(
          future: _distance(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                '${snapshot.data.toInt()} m',
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Container();
          },
        ),
        SizedBox(width: 4),
        Icon(
          FontAwesomeIcons.clock,
          size: 14,
          color: Theme.of(context).accentColor,
        ),
        SizedBox(width: 4),
        Text(
          cafe.openNow != null && cafe.openNow
              ? I18n.of(context).openingHours_open
              : I18n.of(context).openingHours_closed,
          style: TextStyle(
              color: Colors.black54, fontSize: 14, fontWeight: FontWeight.w300),
        ),
      ],
    );
  }

  Future<double> _distance() async {
    final service = sl<LocationService>();
    return service.distanceBetween(currentLocation, cafe.location);
  }
}
