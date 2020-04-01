import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../../../../core/app_logger.dart';
import '../../../../core/either.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../../domain/entities/filter.dart';
import '../../../../domain/entities/location.dart';
import '../../../../domain/exceptions/exceptions.dart';
import '../../../../domain/failure.dart';
import '../../../../domain/repositories/cafe_repository.dart';
import '../../../../domain/repositories/nearby_result.dart';
import '../../../../domain/services/location_service.dart';
import '../../../core/blocs/favorites/bloc.dart' as favorites;
import './cafelist_event.dart';
import './cafelist_state.dart';

class CafeListBloc extends Bloc<CafeListEvent, CafeListState> {
  final CafeRepository _cafeRepository;
  final LocationService _locationService;
  final Logger logger = getLogger('CafeListBloc');

  List<String> _issuedTokens = [];

  final favorites.FavoritesBloc favoritesBloc;

  StreamSubscription<favorites.FavoritesBlocState> _favoritesBlocSubscription;

  CafeListBloc({
    @required CafeRepository cafeRepository,
    @required LocationService locationService,
    @required this.favoritesBloc,
  })  : _cafeRepository = cafeRepository,
        _locationService = locationService {
    _favoritesBlocSubscription = favoritesBloc.listen(_onFavoritesStateChanged);
  }

  @override
  CafeListState get initialState => Loading();

  @override
  Stream<CafeListState> mapEventToState(CafeListEvent event) async* {
    yield* event.map(
      loadNext: _mapLoadNext,
      refresh: _mapRefresh,
      setFavorite: _mapSetFavorite,
      updateTags: _mapUpdateTags,
    );
  }

  void _onFavoritesStateChanged(favorites.FavoritesBlocState favoritesState) {
    final lastUpdate = favoritesState.maybeMap(
      loaded: (l) => l,
      orElse: () => null,
    );
    //if favorites updated -> update screen
    if (lastUpdate?.lastCafeId != null) {
      add(SetFavorite(
        cafeId: lastUpdate.lastCafeId,
        isFavorite: lastUpdate.lastCafeIsFavorite,
      ));
    }
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
          loaded: (cafes, filter, currentLocation, token) {
            return Loaded(
                cafes: [...cafes, ...res.cafes],
                actualFilter: event.filter,
                currentLocation: location,
                nextPageToken: res.nextPageToken);
          },
          orElse: () => null),
      right: (failure) => CafeListState.failure(
        _mapFailureToMessage(failure),
        filter: event.filter,
      ),
    );
  }

  Stream<CafeListState> _mapRefresh(Refresh event) async* {
    yield Loading();
    _issuedTokens = [];
    try {
      final location = await _locationService.getCurrentLocation();
      final result =
          await _cafeRepository.getNearby(location, filter: event.filter);
      yield _mapCafeResultToState(result, event.filter, location);
    } on NoLocationPermissionException {
      yield FailureNoLocationPermission(filter: event.filter);
    } on NoLocationServiceException {
      yield FailureNoLocationService(filter: event.filter);
    }
  }

  Stream<CafeListState> _mapSetFavorite(SetFavorite event) async* {
    yield state.maybeMap(
      loaded: (loaded) {
        final cafes = loaded.cafes;
        final newCafes = cafes.map((cafe) {
          if (cafe.placeId == event.cafeId) {
            return cafe.copyWith(isFavorite: event.isFavorite);
          }
          return cafe;
        }).toList();
        return loaded.copyWith(cafes: newCafes);
      },
      orElse: () => CafeListState.failure(
          'Wrong state when ToggleFavorite called. State was: $state'),
    );
  }

  Stream<CafeListState> _mapUpdateTags(UpdateTags event) async* {
    yield state.maybeMap(
      loaded: (loaded) {
        final cafes = loaded.cafes;
        final newCafes = cafes.map((cafe) {
          if (cafe.placeId == event.cafeId) {
            return cafe.copyWith(tags: event.tags);
          }
          return cafe;
        }).toList();
        return loaded.copyWith(cafes: newCafes);
      },
      orElse: () => CafeListState.failure(
          'Wrong state when ToggleFavorite called. State was: $state'),
    );
  }

  CafeListState _mapCafeResultToState(
    Either<NearbyResult, Failure> result,
    Filter filter,
    Location currentLocation,
  ) {
    return result.when(
      left: (nearby) => Loaded(
        cafes: nearby.cafes,
        actualFilter: filter,
        currentLocation: currentLocation,
        nextPageToken: nearby.nextPageToken,
      ),
      right: (failure) =>
          CafeListState.failure(_mapFailureToMessage(failure), filter: filter),
    );
  }

  //todo move to base
  String _mapFailureToMessage(Failure failure) {
    return failure.when(
      (f) => f.toString(),
      notFound: () => 'Not found',
      serviceFailure: (msg, inner) => 'Service Failed: $msg.\nInner: $inner',
    );
  }

  @override
  Future<void> close() {
    _favoritesBlocSubscription?.cancel();
    return super.close();
  }
}
