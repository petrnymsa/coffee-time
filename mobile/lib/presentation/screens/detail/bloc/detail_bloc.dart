import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/cafe.dart';
import '../../../../domain/failure.dart';
import '../../../../domain/repositories/cafe_repository.dart';
import '../../cafe_list/bloc/cafelist_bloc.dart';
import '../../cafe_list/bloc/cafelist_event.dart' as cafe_list_events;
import 'detail_bloc_event.dart';
import 'detail_bloc_state.dart';

class DetailBloc extends Bloc<DetailBlocEvent, DetailBlocState> {
  final Cafe cafe;
  final CafeListBloc cafeListBloc;
  final CafeRepository cafeRepository;

  DetailBloc({
    @required this.cafe,
    @required this.cafeListBloc,
    @required this.cafeRepository,
  });

  @override
  DetailBlocState get initialState => Loading();

  @override
  Stream<DetailBlocState> mapEventToState(DetailBlocEvent event) async* {
    yield* event.map(
      load: _mapLoadEvent,
      toggleFavorite: _mapToggleFavorite,
      updateTags: _mapUpdateTags,
    );
  }

  Stream<DetailBlocState> _mapLoadEvent(Load event) async* {
    final detailResult = await cafeRepository.getDetail(cafe.placeId);

    yield detailResult.when(
        left: (detail) => Loaded(cafe: cafe, detail: detail),
        right: (failure) =>
            DetailBlocState.failure(_mapFailureToMessage(failure)));
  }

  Stream<DetailBlocState> _mapToggleFavorite(ToggleFavorite event) async* {
    final result = await cafeRepository.toggleFavorite(event.id);

    yield result.when(
        left: (isFavorite) {
          //dispatch event to cafelist - refresh list
          cafeListBloc.add(
            cafe_list_events.SetFavorite(
                cafeId: event.id, isFavorite: isFavorite),
          );

          return state.maybeWhen(
              loaded: (cafe, detail) => Loaded(
                  cafe: cafe.copyWith(isFavorite: isFavorite), detail: detail),
              orElse: () => DetailBlocState.failure(
                  'Wrong state when ToggleFavorite called. State was: $state'));
        },
        right: (failure) =>
            DetailBlocState.failure(_mapFailureToMessage(failure)));
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
}
