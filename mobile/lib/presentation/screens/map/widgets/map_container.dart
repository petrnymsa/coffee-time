import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../di_container.dart';
import '../../../../domain/entities/cafe.dart';
import '../../../../domain/entities/location.dart';
import '../../../../domain/services/location_service.dart';
import '../../../../generated/i18n.dart';
import '../../../assets.dart';
import '../../../core/notification_helper.dart';
import '../../detail/bloc/bloc.dart' as detail_bloc;
import '../../detail/screen.dart';
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
  static const double defaultZoom = 13.5;
  static const double defaultBearing = 0;

  final Completer<GoogleMapController> _controller = Completer();

  BitmapDescriptor cafeIcon;
  BitmapDescriptor flagIcon;

  final LocationService locationService = sl<LocationService>();

  final _markers = <Marker>{};

  @override
  void initState() {
    _loadCafeIcon();
    super.initState();
  }

  void _loadCafeIcon() async {
    cafeIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      Assets.kCoffeeMarker,
    );
    flagIcon = await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(devicePixelRatio: 2.5),
      Assets.kFlag,
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
    cl.animateCamera(CameraUpdate.newLatLngZoom(location, defaultZoom));
  }

  void _onMarkerInfoTap(Cafe cafe) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => BlocProvider<detail_bloc.DetailBloc>(
          create: (_) => sl.get<detail_bloc.DetailBloc>(
            param1: cafe,
          )..add(detail_bloc.Load()),
          child: DetailScreen(),
        ),
      ),
    );
  }

  void _addCafeMarkers() {
    final cafeMarkers = widget.state.cafes
        .map((c) => Marker(
            markerId: MarkerId(c.placeId),
            icon: cafeIcon,
            position: LatLng(c.location.lat, c.location.lng),
            infoWindow: InfoWindow(
              title: c.name,
              snippet: c.address,
              onTap: () => _onMarkerInfoTap(c),
            )))
        .toSet();

    _markers.addAll(cafeMarkers);
  }

  void _addCustomLocationMarker() {
    final position = widget.state.location.toLatLng();
    _markers.add(Marker(
        markerId: MarkerId('custom'), position: position, icon: flagIcon));
  }

  @override
  Widget build(BuildContext context) {
    _markers.clear();
    _addCafeMarkers();

    if (widget.state.customLocation) {
      _addCustomLocationMarker();
    }

    final tr = I18n.of(context);

    return BlocListener<MapBloc, MapBlocState>(
      listener: (context, state) {
        state.maybeMap(
            loaded: (loaded) {
              if (loaded.customLocation) {
                if (loaded.cafes.isEmpty) {
                  context.showNotificationWithLoadingSnackBar(
                      text: tr.notification_loading);
                } else {
                  context.showNotificationSnackBar(
                      text: tr.notification_cafesCoundLoaded(
                    loaded.cafes.length.toString(),
                  ));
                }
              }
            },
            orElse: () {});
      },
      child: Stack(
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
            markers: _markers,
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
              child: const FaIcon(
                FontAwesomeIcons.crosshairs,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
