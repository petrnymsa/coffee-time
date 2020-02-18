import 'dart:async';

import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/providers/cafe_list.dart';
import 'package:coffee_time/presentation/screens/detail/detail.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatefulWidget {
  const MapTab({Key key}) : super(key: key);

  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  // Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Text('Map');
    // return new Scaffold(
    //   body: Consumer<CafeListProvider>(builder: (ctx, model, _) {
    //     return GoogleMap(
    //       mapType: MapType.normal,
    //       initialCameraPosition: CameraPosition(
    //         target:
    //             LatLng(model.currentLocation.lat, model.currentLocation.lng),
    //         zoom: 16,
    //       ),
    //       onMapCreated: (GoogleMapController controller) {
    //         _controller.complete(controller);
    //       },
    //       markers:
    //           model.state == ProviderState.ready ? _buildMarkers(model) : null,
    //       mapToolbarEnabled: true,
    //       compassEnabled: true,
    //       rotateGesturesEnabled: true,
    //     );
    //   }),
    // );
  }

  // _buildMarkers(CafeListProvider model) {
  //   final Set<Marker> markers = {};
  //   model.cafes.forEach((m) {
  //     final cafe = m.entity;
  //     markers.add(
  //       Marker(
  //         markerId: MarkerId(cafe.placeId),
  //         position: LatLng(cafe.location.lat, cafe.location.lng),
  //         infoWindow: InfoWindow(
  //             title: cafe.name,
  //             snippet: cafe.address,
  //             onTap: () async {
  //               await Navigator.of(context).push(
  //                 MaterialPageRoute(
  //                   builder: (_) => DetailScreen(),
  //                   settings: RouteSettings(arguments: cafe.placeId),
  //                 ),
  //               );
  //             }),
  //         onTap: () {},
  //       ),
  //     );
  //   });
  //   return markers;
  // }
}
