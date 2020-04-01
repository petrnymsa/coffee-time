import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/app_logger.dart';
import '../../../../domain/entities/cafe.dart';
import '../../../../domain/failure.dart';
import '../../../../domain/repositories/cafe_repository.dart';
import '../../../core/blocs/favorites/bloc.dart' as favorites;
import '../../cafe_list/bloc/cafelist_bloc.dart';
import '../../cafe_list/bloc/cafelist_event.dart' as cafe_list_events;
import 'detail_bloc_event.dart';
import 'detail_bloc_state.dart';

class DetailBloc extends Bloc<DetailBlocEvent, DetailBlocState> {
  final Cafe cafe;
  final CafeListBloc cafeListBloc;
  final favorites.FavoritesBloc favoritesBloc;
  final CafeRepository cafeRepository;

  StreamSubscription<favorites.FavoritesBlocState> _favoritesBlocSubscription;

  DetailBloc({
    @required this.cafe,
    @required this.cafeListBloc,
    @required this.cafeRepository,
    @required this.favoritesBloc,
  }) {
    _favoritesBlocSubscription = favoritesBloc.listen(_onFavoritesStateChanged);
  }

  @override
  DetailBlocState get initialState => Loading();

  @override
  Stream<DetailBlocState> mapEventToState(DetailBlocEvent event) async* {
    yield* event.map(
      load: _mapLoadEvent,
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

  Stream<DetailBlocState> _mapLoadEvent(Load event) async* {
    final detailResult = await cafeRepository.getDetail(cafe.placeId);

    yield detailResult.when(
        left: (detail) => Loaded(cafe: cafe, detail: detail),
        right: (failure) =>
            DetailBlocState.failure(_mapFailureToMessage(failure)));
  }

  Stream<DetailBlocState> _mapSetFavorite(SetFavorite event) async* {
    //final result = await cafeRepository.toggleFavorite(event.id);
    yield state.maybeMap(
        loaded: (loaded) {
          if (loaded.cafe.placeId != event.cafeId) {
            return loaded;
          }
          return loaded.copyWith(
              cafe: cafe.copyWith(isFavorite: event.isFavorite));
        },
        orElse: () => DetailBlocState.failure(
            'Wrong state when ToggleFavorite called. State was: $state'));
  }

  Stream<DetailBlocState> _mapUpdateTags(UpdateTags event) async* {
    if (event.tags.isEmpty) {
      return;
    }

    final result = await cafeRepository.updateTagsForCafe(event.id, event.tags);

    yield result.when(
      left: (updatedTags) => state.maybeMap(
          loaded: (loaded) {
            //dispatch event to cafelist - refresh tags
            cafeListBloc.add(
              cafe_list_events.UpdateTags(cafeId: event.id, tags: updatedTags),
            );

            return loaded.copyWith(cafe: cafe.copyWith(tags: updatedTags));
          },
          orElse: () => DetailBlocState.failure(
              'Wrong state when UpdateTags called. State was: $state')),
      right: (failure) =>
          DetailBlocState.failure(_mapFailureToMessage(failure)),
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

  @override
  Future<void> close() {
    _favoritesBlocSubscription?.cancel();
    return super.close();
  }
}
