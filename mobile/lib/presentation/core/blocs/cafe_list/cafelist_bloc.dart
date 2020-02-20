import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';

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

  StreamSubscription<Location> _locationStreamSubscription;

  CafeListBloc({
    @required CafeRepository cafeRepository,
    @required LocationService locationService,
  })  : _cafeRepository = cafeRepository,
        _locationService = locationService {
    _locationStreamSubscription = _locationService
        .getLocationStream(distanceFilter: 100)
        .listen((location) {
      add(LoadNearby(location));
    });
  }

  @override
  CafeListState get initialState => Loading();

  // @override
  // Stream<CafeListState> transform(
  //   Stream<CafeListState> events,
  //   Stream<CafeListState> Function(CafeListEvent event) next,
  // ) {
  //   return super.transform(
  //     (events as Observable<CafeListState>).debounceTime(
  //       Duration(milliseconds: 500),
  //     ),
  //     next,
  //   );
  // }
  @override
  Stream<CafeListState> transformEvents(Stream<CafeListEvent> events,
      Stream<CafeListState> Function(CafeListEvent) next) {
    return super.transformEvents(
        events.debounceTime(Duration(microseconds: 1000)), next);

    // return (events as Observable<CafeListEvent>)
    //     .debounceTime(
    //       Duration(milliseconds: 300),
    //     )
    //     .switchMap(next);
  }

  @override
  Stream<CafeListState> mapEventToState(CafeListEvent event) async* {
    yield* event.map(
      loadNearby: _mapLoadNearby,
      loadQuery: _mapLoadQuery,
      setFilter: _mapSetFilter,
    );
  }

  Stream<CafeListState> _mapLoadNearby(LoadNearby event) async* {
    logger.i('recieved LoadNearby event $event');
    yield Loading();
    final result = await _cafeRepository.getNearby(event.location,
        filter: Filter(onlyOpen: false));

    yield result.when(
      left: (cafes) {
        logger.i('got ${cafes.length} cafes');
        return Loaded(cafes);
      },
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

  @override
  Future<void> close() async {
    await _locationStreamSubscription?.cancel();
    return super.close();
  }
}
