import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/failure.dart';
import 'package:coffee_time/domain/repositories/cafe_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/blocs/cafe_list/cafelist_bloc.dart';
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
    );
  }

  Stream<DetailBlocState> _mapLoadEvent(Load event) async* {
    final detailResult = await cafeRepository.getDetail(cafe.placeId);

    yield detailResult.when(
        left: (detail) => Loaded(cafe: cafe, detail: detail),
        right: (failure) =>
            DetailBlocState.failure(_mapFailureToMessage(failure)));
  }

  Stream<DetailBlocState> _mapToggleFavorite(ToggleFavorite event) {}

  //todo move to base bloc class
  String _mapFailureToMessage(Failure failure) {
    return failure.when(
      (f) => f.toString(),
      notFound: () => 'Not found',
      serviceFailure: (msg, inner) => 'Service Failed: $msg.\nInner: $inner',
    );
  }
}
