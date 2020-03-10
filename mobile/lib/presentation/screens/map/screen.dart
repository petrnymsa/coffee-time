import 'package:flutter/material.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Map screen'),
    );
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
