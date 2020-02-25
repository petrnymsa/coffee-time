import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/repositories/nearby_result.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/either.dart';
import '../../../../core/app_logger.dart';
import '../../../../domain/entities/filter.dart';
import '../../../../domain/entities/location.dart';
import '../../../../domain/failure.dart';
import '../../../../domain/repositories/cafe_repository.dart';
import '../../../../domain/services/location_service.dart';
import './cafelist_event.dart';
import './cafelist_state.dart';

class CafeListBloc extends Bloc<CafeListEvent, CafeListState> {
  final CafeRepository _cafeRepository;
  final LocationService _locationService;
  final Logger logger = getLogger('CafeListBloc');

  List<String> _tokens = [];

  // StreamSubscription<Location> _locationStreamSubscription;

  CafeListBloc({
    @required CafeRepository cafeRepository,
    @required LocationService locationService,
  })  : _cafeRepository = cafeRepository,
        _locationService = locationService {
    //todo emit load nearby when distance > 1000m
    // _locationStreamSubscription = _locationService
    //     .getLocationStream(distanceFilter: 100)
    //     .listen((location) {
    //   add(LoadNearby(location));
    // });

    //  add(Refresh());
  }

  @override
  CafeListState get initialState => Loading();

  // @override
  // Stream<CafeListState> transformEvents(Stream<CafeListEvent> events,
  //     Stream<CafeListState> Function(CafeListEvent) next) {
  //   return super.transformEvents(
  //       events.debounceTime(Duration(microseconds: 500)), next);
  // }

  @override
  Stream<CafeListState> mapEventToState(CafeListEvent event) async* {
    //logger.d('got event: $event');
    yield* event.map(
        loadNearby: _mapLoadNearby,
        loadNext: _mapLoadNext,
        loadQuery: _mapLoadQuery,
        setFilter: _mapSetFilter,
        refresh: _mapRefresh);
  }

  Stream<CafeListState> _mapLoadNearby(LoadNearby event) async* {
    logger.d('recieved LoadNearby event $event');
    yield Loading();
    final result = await _cafeRepository.getNearby(event.location);
    final s = _mapCafeResultToState(result);
    logger.d('returning $s');
    yield s;
  }

  Stream<CafeListState> _mapLoadNext(LoadNext event) async* {
    if (event.pageToken == null) {
      logger.i('Ignoring LoadNext event');
      return;
    }

    _tokens.add(event.pageToken);

    logger.d('recieved LoadNext event');
    final location = await _locationService.getCurrentLocation();
    final result = await _cafeRepository.getNearby(location,
        pageToken: event.pageToken); //todo filter
    yield result.when(
        left: (res) {
          final existingCafes = state.maybeWhen(
              loaded: (cafes, t) {
                logger.i('new token vs old token: ${res.nextPageToken == t}');
                return cafes;
              },
              orElse: () => []);

          return Loaded(
              cafes: [...existingCafes, ...res.cafes],
              nextPage: res.nextPageToken);
        },
        right: (failure) =>
            CafeListState.failure(_mapFailureToMessage(failure)));

    // final existingCafes =
    //     state.maybeWhen(loaded: (cafes, _) => cafes, orElse: () => []);
    // existingCafes.shuffle();
    // yield Loaded(cafes: [...existingCafes, ...existingCafes], nextPage: 'abc');
  }

  Stream<CafeListState> _mapLoadQuery(LoadQuery event) async* {
    logger.d('recieved LoadNearby event $event');
    yield CafeListState.failure('not implemented');
  }

  Stream<CafeListState> _mapSetFilter(SetFilter event) async* {
    logger.d('recieved LoadNearby event $event');
    yield CafeListState.failure('not implemented');
  }

  Stream<CafeListState> _mapRefresh(Refresh event) async* {
    //logger.d('recieved refresh event');
    final location = await _locationService.getCurrentLocation();
    final result = await _cafeRepository.getNearby(location);
    final s = _mapCafeResultToState(result);
    yield s;
  }

  CafeListState _mapCafeResultToState(Either<NearbyResult, Failure> result) {
    return result.when(
      left: (nearby) {
        logger.i(
            'got ${nearby.cafes.length} cafes, token: ${nearby.nextPageToken != null}');
        return Loaded(cafes: nearby.cafes, nextPage: nearby.nextPageToken);
      },
      right: (failure) => CafeListState.failure(_mapFailureToMessage(failure)),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    return failure.when(
      (f) => f.toString(),
      notFound: () => 'Not found',
      serviceFailure: (msg, inner) => 'Service Failed: $msg.\nInner: $inner',
    );
  }

  @override
  Future<void> close() async {
    //   await _locationStreamSubscription?.cancel();
    return super.close();
  }
}
