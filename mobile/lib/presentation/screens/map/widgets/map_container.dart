import 'dart:async';

import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/domain/services/location_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logger/logger.dart';

import '../../../../core/app_logger.dart';
import '../../../../di_container.dart';
import '../../../../domain/entities/cafe.dart';
import '../bloc/bloc.dart';

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
  static const double defaultZoom = 16;
  static const double defaultBearing = 0;

  final Completer<GoogleMapController> _controller = Completer();
  final Logger logger = getLogger('MapScreen');

  BitmapDescriptor cafeIcon;

  final LocationService locationService = sl<LocationService>();

  @override
  void initState() {
    _loadCafeIcon();
    super.initState();
  }

  Set<Marker> _createMarkers(List<Cafe> cafes) {
    final markers = <Marker>{};

    for (final c in cafes) {
      markers.add(Marker(
        markerId: MarkerId(c.placeId),
        icon: cafeIcon,
        position: LatLng(c.location.lat, c.location.lng),
        infoWindow: InfoWindow(
            title: c.name,
            snippet: c.address,
            onTap: () async {
              // await Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (_) => DetailScreen(),
              //   ),
              // );
            }),
      ));
    }

    return markers;
  }

  void _loadCafeIcon() async {
    cafeIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      'assets/coffee-shop-marker.png',
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Future<void> _moveToCurrentLocation() async {
    final location = await locationService.getCurrentLocation();
    final cl = await _controller.future;
    cl.animateCamera(
        CameraUpdate.newLatLng(LatLng(location.lat, location.lng)));
  }

  void _onStateChanged(BuildContext context, MapBlocState state) {
    // state.maybeWhen(
    //   loaded: (cafes, location) async {
    //     final cl = await _controller.future;
    //     cl.animateCamera(
    //         CameraUpdate.newLatLng(LatLng(location.lat, location.lng)));
    //   },
    //   orElse: () {},
    // );
  }

  @override
  Widget build(BuildContext context) {
    logger.i('Rebuild');
    return Stack(
      children: [
        BlocListener<MapBloc, MapBlocState>(
          listener: _onStateChanged,
          child: GoogleMap(
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
            onTap: print,
            markers: _createMarkers(widget.state.cafes),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: true,
            rotateGesturesEnabled: true,
          ),
        ),
        Positioned(
          right: 10,
          bottom: 10,
          child: FloatingActionButton(
            onPressed: () {
              context
                  .bloc<MapBloc>()
                  .add(SetCurrentLocation(filter: Filter(onlyOpen: false)));
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
