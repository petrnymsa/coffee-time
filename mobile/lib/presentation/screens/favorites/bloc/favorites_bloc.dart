import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/failure.dart';
import '../../../../domain/repositories/cafe_repository.dart';
import '../../cafe_list/bloc/cafelist_bloc.dart';
import '../../cafe_list/bloc/cafelist_event.dart' as cafe_list_events;
import 'favorites_bloc_event.dart';
import 'favorites_bloc_state.dart';

class FavoritesBloc extends Bloc<FavoritesBlocEvent, FavoritesBlocState> {
  final CafeListBloc cafeListBloc;
  final CafeRepository cafeRepository;

  FavoritesBloc({@required this.cafeListBloc, @required this.cafeRepository});

  @override
  FavoritesBlocState get initialState => Loading();

  @override
  Stream<FavoritesBlocState> mapEventToState(FavoritesBlocEvent event) async* {
    yield* event.map(
      load: _mapLoadEvent,
      toggleFavorite: _mapToggleFavorite,
    );
  }

  Stream<FavoritesBlocState> _mapLoadEvent(Load event) async* {
    final result = await cafeRepository.getFavorites();

    yield result.when(
        left: (cafes) => Loaded(cafes),
        right: (failure) =>
            FavoritesBlocState.failure(_mapFailureToMessage(failure)));
  }

  Stream<FavoritesBlocState> _mapToggleFavorite(ToggleFavorite event) async* {
    final result = await cafeRepository.toggleFavorite(event.id);

    yield result.when(
        left: (isFavorite) {
          //dispatch event to cafelist - refresh list
          cafeListBloc.add(cafe_list_events.SetFavorite(
              cafeId: event.id, isFavorite: isFavorite));

          return state.maybeWhen(
              loaded: (cafes) {
                final newCafes = cafes.map((cafe) {
                  if (cafe.placeId == event.id) {
                    return cafe.copyWith(isFavorite: isFavorite);
                  }
                  return cafe;
                }).toList();

                return Loaded(newCafes);
              },
              orElse: () => FavoritesBlocState.failure(
                  'Wrong state when ToggleFavorite called. State was: $state'));
        },
        right: (failure) =>
            FavoritesBlocState.failure(_mapFailureToMessage(failure)));
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
