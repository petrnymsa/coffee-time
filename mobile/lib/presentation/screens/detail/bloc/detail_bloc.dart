import 'package:flutter_bloc/flutter_bloc.dart';

import 'detail_bloc_event.dart';
import 'detail_bloc_state.dart';

class DetailBloc extends Bloc<DetailBlocEvent, DetailBlocState> {
  @override
  DetailBlocState get initialState => Loading();

  @override
  Stream<DetailBlocState> mapEventToState(DetailBlocEvent event) async* {
    yield* event.map(
      load: _mapLoadEvent,
      toggleFavorite: _mapToggleFavorite,
    );
  }

  Stream<DetailBlocState> _mapLoadEvent(Load event) {}

  Stream<DetailBlocState> _mapToggleFavorite(ToggleFavorite event) {}
}
