import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/shared_widgets.dart';
import 'bloc/bloc.dart';
import 'widgets/widgets.dart';

class MapScreen extends StatefulWidget {
  MapScreen({Key key}) : super(key: key) {
    print('Constructor');
  }

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapBlocState>(
      builder: (context, state) => state.map(
        loading: (loading) => CircularLoader(),
        loaded: (loaded) => MapContainer(state: loaded),
        failure: (failure) => FailureContainer(
          message: failure.message,
          onRefresh: null,
        ),
      ),
    );
  }
}
