import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/filter.dart';
import '../../../../domain/entities/location.dart';
import '../../../../domain/exceptions/exceptions.dart';
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
  }) : super(Loading());

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
    yield Loading();
    try {
      final location = await locationService.getCurrentLocation();
      yield await _getAllNearbyAndMapState(location, event.filter,
          customLocation: false);
    } on NoLocationPermissionException {
      yield FailureNoLocationPermission(filter: event.filter);
    } on NoLocationServiceException {
      yield FailureNoLocationService(filter: event.filter);
    }
  }

  Stream<MapBlocState> _mapFilterChanged(FilterChanged event) async* {
    final filter = event.filter;

    final location = state.maybeMap(
      loaded: (l) => l.location,
      orElse: () => null,
    );

    final customLocation = state.maybeMap(
      loaded: (l) => l.customLocation,
      orElse: () => null,
    );

    if (location == null) {
      yield* _mapSetCurrentLocation(SetCurrentLocation(filter: filter));
    } else {
      yield await _getAllNearbyAndMapState(location, event.filter,
          customLocation: customLocation ?? false);
    }
  }

  Stream<MapBlocState> _mapSetLocation(SetLocation event) async* {
    yield Loaded(
      location: event.location,
      cafes: [],
      filter: event.filter,
      customLocation: true,
    );
    yield await _getAllNearbyAndMapState(event.location, event.filter,
        customLocation: true);
  }

  Stream<MapBlocState> _mapSetCurrentLocation(SetCurrentLocation event) async* {
    try {
      final location = await locationService.getCurrentLocation();
      yield await _getAllNearbyAndMapState(location, event.filter,
          customLocation: false);
    } on NoLocationPermissionException {
      yield FailureNoLocationPermission(filter: event.filter);
    } on NoLocationServiceException {
      yield FailureNoLocationService(filter: event.filter);
    }
  }

  Future<MapBlocState> _getAllNearbyAndMapState(
      Location location, Filter filter,
      {@required bool customLocation}) async {
    final result = await cafeRepository.getAllNearby(location, filter: filter);

    return result.when(
      left: (cafes) => Loaded(
        cafes: cafes,
        location: location,
        filter: filter,
        customLocation: customLocation,
      ),
      right: (failure) => MapBlocState.failure(
        _mapFailureToMessage(failure),
        filter: filter,
      ),
    );
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
