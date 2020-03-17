import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../../../../core/app_logger.dart';
import '../../../../core/either.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../../domain/entities/filter.dart';
import '../../../../domain/failure.dart';
import '../../../../domain/repositories/cafe_repository.dart';
import '../../../../domain/repositories/nearby_result.dart';
import '../../../../domain/services/location_service.dart';
import './cafelist_event.dart';
import './cafelist_state.dart';

class CafeListBloc extends Bloc<CafeListEvent, CafeListState> {
  final CafeRepository _cafeRepository;
  final LocationService _locationService;
  final Logger logger = getLogger('CafeListBloc');
  // StreamSubscription<Location> _locationStreamSubscription;

  List<String> _issuedTokens = [];

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
  }

  @override
  CafeListState get initialState => Loading();

  @override
  Stream<CafeListState> mapEventToState(CafeListEvent event) async* {
    yield* event.map(
      loadNearby: _mapLoadNearby,
      loadNext: _mapLoadNext,
      loadQuery: _mapLoadQuery,
      refresh: _mapRefresh,
      toggleFavorite: _mapToggleFavorite,
      setFavorite: _mapSetFavorite,
      updateTags: _mapUpdateTags,
    );
  }

  Stream<CafeListState> _mapLoadNearby(LoadNearby event) async* {
    _issuedTokens = [];

    yield Loading();
    final result =
        await _cafeRepository.getNearby(event.location, filter: event.filter);
    yield _mapCafeResultToState(result, event.filter);
  }

  Stream<CafeListState> _mapLoadNext(LoadNext event) async* {
    if (event.pageToken == null) {
      logger.d('Ignoring LoadNext');
      return;
    }

    if (_issuedTokens.contains(event.pageToken)) {
      logger.w(
          'Ignoring LoadNext - ...${event.pageToken.last(10)} already present');
      return;
    }

    _issuedTokens.add(event.pageToken);

    final location = await _locationService.getCurrentLocation();
    final result = await _cafeRepository.getNearby(
      location,
      pageToken: event.pageToken,
      filter: event.filter,
    );
    yield result.when(
        left: (res) => state.maybeWhen(
            loaded: (cafes, filter, token) {
              return Loaded(
                  cafes: [...cafes, ...res.cafes],
                  actualFilter: event.filter,
                  nextPageToken: res.nextPageToken);
            },
            orElse: () => null),
        right: (failure) =>
            CafeListState.failure(_mapFailureToMessage(failure)));
  }

  Stream<CafeListState> _mapLoadQuery(LoadQuery event) async* {
    logger.d('recieved LoadNearby event $event');
    yield CafeListState.failure('not implemented');
  }

  Stream<CafeListState> _mapRefresh(Refresh event) async* {
    yield Loading();
    _issuedTokens = [];
    final location = await _locationService.getCurrentLocation();
    final result =
        await _cafeRepository.getNearby(location, filter: event.filter);
    yield _mapCafeResultToState(result, event.filter);
  }

  Stream<CafeListState> _mapToggleFavorite(ToggleFavorite event) async* {
    final result = await _cafeRepository.toggleFavorite(event.cafeId);

    yield result.when(
      left: (isFavorite) => state.maybeWhen(
          loaded: (cafes, filter, token) {
            final newCafes = cafes.map((cafe) {
              if (cafe.placeId == event.cafeId) {
                return cafe.copyWith(isFavorite: isFavorite);
              }
              return cafe;
            }).toList();

            return Loaded(
                cafes: newCafes, actualFilter: filter, nextPageToken: token);
          },
          orElse: () => CafeListState.failure(
              'Wrong state when ToggleFavorite called. State was: $state')),
      right: (failure) => CafeListState.failure(_mapFailureToMessage(failure)),
    );
  }

  Stream<CafeListState> _mapSetFavorite(SetFavorite event) async* {
    yield state.maybeWhen(
      loaded: (cafes, filter, token) {
        final newCafes = cafes.map((cafe) {
          if (cafe.placeId == event.cafeId) {
            return cafe.copyWith(isFavorite: event.isFavorite);
          }
          return cafe;
        }).toList();

        return Loaded(
            cafes: newCafes, actualFilter: filter, nextPageToken: token);
      },
      orElse: () => CafeListState.failure(
          'Wrong state when ToggleFavorite called. State was: $state'),
    );
  }

  Stream<CafeListState> _mapUpdateTags(UpdateTags event) async* {
    yield state.maybeWhen(
      loaded: (cafes, filter, token) {
        final newCafes = cafes.map((cafe) {
          if (cafe.placeId == event.cafeId) {
            return cafe.copyWith(tags: event.tags);
          }
          return cafe;
        }).toList();

        return Loaded(
            cafes: newCafes, actualFilter: filter, nextPageToken: token);
      },
      orElse: () => CafeListState.failure(
          'Wrong state when ToggleFavorite called. State was: $state'),
    );
  }

  CafeListState _mapCafeResultToState(
      Either<NearbyResult, Failure> result, Filter filter) {
    return result.when(
      left: (nearby) => Loaded(
        cafes: nearby.cafes,
        actualFilter: filter,
        nextPageToken: nearby.nextPageToken,
      ),
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
