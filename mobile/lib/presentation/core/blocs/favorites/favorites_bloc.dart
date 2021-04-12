import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/either.dart';
import '../../../../domain/failure.dart';
import '../../../../domain/repositories/cafe_repository.dart';
import 'favorites_bloc_event.dart';
import 'favorites_bloc_state.dart';

class FavoritesBloc extends Bloc<FavoritesBlocEvent, FavoritesBlocState> {
  final CafeRepository cafeRepository;

  FavoritesBloc({@required this.cafeRepository}) : super(Loading());

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
        left: (cafes) => Loaded(cafes: cafes),
        right: (failure) =>
            FavoritesBlocState.failure(_mapFailureToMessage(failure)));
  }

  Stream<FavoritesBlocState> _mapToggleFavorite(ToggleFavorite event) async* {
    final isFavoriteResult = await cafeRepository.toggleFavorite(event.id);

    if (isFavoriteResult is Failure) {
      final failure = (isFavoriteResult as Failure);
      yield FavoritesBlocState.failure(_mapFailureToMessage(failure));
      return;
    }
    final isFavorite = (isFavoriteResult as Left<bool, Failure>).left;

    yield state.maybeMap(
      loaded: (loaded) {
        final cafes = loaded.cafes.map((c) {
          if (c.placeId == event.id) {
            return c.copyWith(isFavorite: isFavorite);
          }
          return c;
        }).toList();

        return loaded.copyWith(
          cafes: cafes,
          lastCafeId: event.id,
          lastCafeIsFavorite: isFavorite,
        );
      },
      orElse: () => FavoritesBlocState.failure('Forbidden state $state'),
    );

    //todo improvement -> get first favoritesIds and then make difference
    //* -> then exclusion call to service
    // * this can prevent too many call to api
    final result = await cafeRepository.getFavorites();

    yield result.when(
        left: (cafes) => Loaded(cafes: cafes),
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
