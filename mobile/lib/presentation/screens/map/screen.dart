import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/shared_widgets.dart';
import 'bloc/bloc.dart';
import 'widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapBlocState>(
      builder: (context, state) => state.map(
        loading: (loading) => const CircularLoader(),
        loaded: (loaded) => MapContainer(state: loaded),
        failure: (failure) => FailureContainer(
          message: failure.message,
          onRefresh: () {
            context.bloc<MapBloc>().add(Init(filter: failure.filter));
          },
        ),
        failureNoLocationPermission: (f) => NoLocationPermission(
          onPermissionGranted: () =>
              context.bloc<MapBloc>().add(Init(filter: f.filter)),
        ),
        failureNoLocationService: (f) => NoLocationService(
          onLocationServiceOpened: () =>
              context.bloc<MapBloc>().add(Init(filter: f.filter)),
        ),
      ),
    );
  }
}
