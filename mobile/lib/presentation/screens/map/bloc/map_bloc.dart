import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/filter.dart';
import '../../../../domain/entities/location.dart';
import '../../../../domain/failure.dart';
import '../../../../domain/repositories/cafe_repository.dart';
import '../../../../domain/services/location_service.dart';
import 'map_bloc_event.dart';
import 'map_bloc_state.dart';

class MapBloc extends Bloc<MapBlocEvent, MapBlocState> {
  final CafeRepository cafeRepository;
  final LocationService locationService;

  MapBloc({
    @required this.cafeRepository,
    @required this.locationService,
  });

  @override
  MapBlocState get initialState => Loading();

  @override
  Stream<MapBlocState> mapEventToState(MapBlocEvent event) async* {
    yield* event.map(
      init: _mapInit,
      setLocation: _mapSetLocation,
      setCurrentLocation: _mapSetCurrentLocation,
      filterChanged: _mapFilterChanged,
    );
  }

  Stream<MapBlocState> _mapInit(Init event) async* {
    final location = await locationService.getCurrentLocation();
    yield await _getAllNearbyAndMapState(location, event.filter);
  }

  Stream<MapBlocState> _mapFilterChanged(FilterChanged event) async* {
    final filter = event.filter;

    final location = state.maybeWhen(
      loaded: (cafes, location, filter) => location,
      orElse: () => null,
    );

    if (location == null) {
      yield* _mapSetCurrentLocation(SetCurrentLocation(filter: filter));
    } else {
      yield* _mapSetLocation(SetLocation(location, filter: filter));
    }
  }

  Stream<MapBlocState> _mapSetLocation(SetLocation event) async* {
    yield await _getAllNearbyAndMapState(event.location, event.filter);
  }

  Stream<MapBlocState> _mapSetCurrentLocation(SetCurrentLocation event) async* {
    final location = await locationService.getCurrentLocation();
    yield await _getAllNearbyAndMapState(location, event.filter);
  }

  Future<MapBlocState> _getAllNearbyAndMapState(
      Location location, Filter filter) async {
    final result = await cafeRepository.getAllNearby(location, filter: filter);

    return result.when(
        left: (cafes) =>
            Loaded(cafes: cafes, location: location, filter: filter),
        right: (failure) =>
            MapBlocState.failure(_mapFailureToMessage(failure)));
  }

  //todo move to base bloc class
  String _mapFailureToMessage(Failure failure) {
    return failure.when(
      (f) => f.toString(),
      notFound: () => 'Not found',
      serviceFailure: (msg, inner) => 'Service Failed: $msg.\nInner: $inner',
    );
  }
}
