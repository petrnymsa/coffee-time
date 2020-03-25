import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

import '../../../../core/app_logger.dart';
import '../../../../di_container.dart';
import '../../../../domain/entities/location.dart';
import '../../../../domain/services/location_service.dart';
import '../bloc/bloc.dart';

// helper function to convert between Location <-> LatLng
extension on Location {
  LatLng toLatLng() => LatLng(lat, lng);
}

extension on LatLng {
  Location toLocation() => Location(latitude, longitude);
}

class MapContainer extends StatefulWidget {
  final Loaded state;

  MapContainer({
    Key key,
    @required this.state,
  }) : super(key: key);

  @override
  _MapContainerState createState() => _MapContainerState();
}

class _MapContainerState extends State<MapContainer> {
  static const double defaultZoom = 15.5;
  static const double defaultBearing = 0;

  final Completer<GoogleMapController> _controller = Completer();
  final Logger logger = getLogger('MapScreen');

  BitmapDescriptor cafeIcon;
  BitmapDescriptor flagIcon;

  final LocationService locationService = sl<LocationService>();

  @override
  void initState() {
    _loadCafeIcon();
    super.initState();
  }

  void _loadCafeIcon() async {
    //todo assets constants
    cafeIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/coffee-shop-marker.png',
    );
    flagIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/flag.png',
    );
    setState(() {});
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _onMapPressed(LatLng tappedLocation) {
    _moveCameraToLocation(tappedLocation);
    final location = tappedLocation.toLocation();
    context
        .bloc<MapBloc>()
        .add(SetLocation(location, filter: widget.state.filter));
  }

  Future<void> _moveToCurrentLocation() async {
    final location = await locationService.getCurrentLocation();
    await _moveCameraToLocation(LatLng(location.lat, location.lng));
  }

  Future<void> _moveCameraToLocation(LatLng location) async {
    final cl = await _controller.future;
    cl.animateCamera(CameraUpdate.newLatLng(location));
  }

  @override
  Widget build(BuildContext context) {
    logger.i('Rebuild');
    final markers = widget.state.cafes
        .map((c) => Marker(
            markerId: MarkerId(c.placeId),
            icon: cafeIcon,
            position: LatLng(c.location.lat, c.location.lng),
            infoWindow: InfoWindow(
              title: c.name,
              snippet: c.address,
              onTap: () {}, //todo detail
            )))
        .toSet();
    if (widget.state.customLocation) {
      final position = widget.state.location.toLatLng();
      markers.add(Marker(
          markerId: MarkerId('custom'), position: position, icon: flagIcon));
    }

    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(
              widget.state.location.lat,
              widget.state.location.lng,
            ),
            zoom: defaultZoom,
            bearing: defaultBearing,
          ),
          onMapCreated: _onMapCreated,
          onLongPress: _onMapPressed,
          markers: markers,
          // widget.state.cafes
          //     .map(
          //       (c) => Marker(
          //         markerId: MarkerId(c.placeId),
          //         icon: cafeIcon,
          //         position: LatLng(c.location.lat, c.location.lng),
          //         infoWindow: InfoWindow(
          //           title: c.name,
          //           snippet: c.address,
          //           onTap: () {}, //todo detail
          //         ),
          //       ),
          //     )
          //     .toSet(),          // polygons: widget.state.customLocation
          //     ? _createCustomLocationPolygon()
          //     : null,
          myLocationEnabled: true,
          myLocationButtonEnabled: false,
          mapToolbarEnabled: false,
          compassEnabled: true,
          rotateGesturesEnabled: true,
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: FloatingActionButton(
            onPressed: () {
              context
                  .bloc<MapBloc>()
                  .add(SetCurrentLocation(filter: widget.state.filter));
              _moveToCurrentLocation();
            },
            child: Icon(
              FontAwesomeIcons.crosshairs,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
