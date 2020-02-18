import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:flutter/foundation.dart';

import '../../../../domain/failure.dart';
import '../../../../domain/repositories/cafe_repository.dart';
import '../../../../domain/services/location_service.dart';
import './cafelist_event.dart';
import './cafelist_state.dart';

class CafeListBloc extends Bloc<CafeListEvent, CafeListState> {
  final CafeRepository _cafeRepository;
  final LocationService _locationService;

  CafeListBloc({
    @required CafeRepository cafeRepository,
    @required LocationService locationService,
  })  : _cafeRepository = cafeRepository,
        _locationService = locationService;

  @override
  CafeListState get initialState => Loading();

  @override
  Stream<CafeListState> mapEventToState(CafeListEvent event) async* {
    yield* event.map(
      loadNearby: _mapLoadNearby,
      loadQuery: _mapLoadQuery,
      setFilter: _mapSetFilter,
    );
  }

  Stream<CafeListState> _mapLoadNearby(LoadNearby event) async* {
    yield Loading();
    final result = await _cafeRepository.getNearby(event.location,
        filter: Filter(onlyOpen: false));

    yield result.when(
      left: (cafes) => Loaded(cafes),
      right: (failure) => CafeListState.failure(_mapFailureToMessage(failure)),
    );
  }

  Stream<CafeListState> _mapLoadQuery(LoadQuery event) {
    return null;
  }

  Stream<CafeListState> _mapSetFilter(SetFilter event) {
    return null;
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.when(
      (f) => f.toString(),
      notFound: () => 'Not found',
      serviceFailure: (msg, inner) => 'Service Failed: $msg.\nInner: $inner',
    );
  }
}
