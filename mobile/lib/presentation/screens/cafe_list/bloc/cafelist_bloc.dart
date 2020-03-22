import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../../../../core/app_logger.dart';
import '../../../../core/either.dart';
import '../../../../core/utils/string_utils.dart';
import '../../../../domain/entities/filter.dart';
import '../../../../domain/entities/location.dart';
import '../../../../domain/failure.dart';
import '../../../../domain/repositories/cafe_repository.dart';
import '../../../../domain/repositories/nearby_result.dart';
import '../../../../domain/services/location_service.dart';
import '../../../core/blocs/filter/bloc.dart';
import './cafelist_event.dart';
import './cafelist_state.dart';

class CafeListBloc extends Bloc<CafeListEvent, CafeListState> {
  final CafeRepository _cafeRepository;
  final LocationService _locationService;
  final Logger logger = getLogger('CafeListBloc');
  final FilterBloc filterBloc;

  StreamSubscription<FilterBlocState> _filterBlocSubscription;

  List<String> _issuedTokens = [];

  CafeListBloc(
      {@required CafeRepository cafeRepository,
      @required LocationService locationService,
      @required this.filterBloc})
      : _cafeRepository = cafeRepository,
        _locationService = locationService {
    //subscribe to FilterBloc recieve updated filter
    _filterBlocSubscription = filterBloc.listen(_onFilterBlocStateChanged);
  }

  @override
  CafeListState get initialState => Loading();

  @override
  Stream<CafeListState> mapEventToState(CafeListEvent event) async* {
    yield* event.map(
      loadNext: _mapLoadNext,
      refresh: _mapRefresh,
      toggleFavorite: _mapToggleFavorite,
      setFavorite: _mapSetFavorite,
      updateTags: _mapUpdateTags,
    );
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
        right: (failure) =>
            CafeListState.failure(_mapFailureToMessage(failure)));
  }

  Stream<CafeListState> _mapRefresh(Refresh event) async* {
    yield Loading();
    _issuedTokens = [];
    final location = await _locationService.getCurrentLocation();
    final result =
        await _cafeRepository.getNearby(location, filter: event.filter);
    yield _mapCafeResultToState(result, event.filter, location);
  }

  Stream<CafeListState> _mapToggleFavorite(ToggleFavorite event) async* {
    final result = await _cafeRepository.toggleFavorite(event.cafeId);

    yield result.when(
      left: (isFavorite) => state.maybeMap(
          loaded: (loaded) {
            final cafes = loaded.cafes;
            final newCafes = cafes.map((cafe) {
              if (cafe.placeId == event.cafeId) {
                return cafe.copyWith(isFavorite: isFavorite);
              }
              return cafe;
            }).toList();
            return loaded.copyWith(cafes: newCafes);
            // return Loaded(
            //   cafes: newCafes,
            //   actualFilter: filter,
            //   currentLocation: currentLocation,
            //   nextPageToken: token,
            // );
          },
          orElse: () => CafeListState.failure(
              'Wrong state when ToggleFavorite called. State was: $state')),
      right: (failure) => CafeListState.failure(_mapFailureToMessage(failure)),
    );
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
        // return Loaded(
        //     cafes: newCafes, actualFilter: filter, nextPageToken: token);
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
        // return Loaded(
        //     cafes: newCafes, actualFilter: filter, nextPageToken: token);
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
      right: (failure) => CafeListState.failure(_mapFailureToMessage(failure)),
    );
  }

  void _onFilterBlocStateChanged(FilterBlocState state) {
    // new filter set -> refresh data
    add(Refresh(filter: state.filter));
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
  Future<void> close() async {
    await _filterBlocSubscription?.cancel();
    return super.close();
  }
}
