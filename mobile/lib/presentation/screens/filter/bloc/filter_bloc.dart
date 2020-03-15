import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/filter.dart';
import 'filter_bloc_event.dart';
import 'filter_bloc_state.dart';

class FilterBloc extends Bloc<FilterBlocEvent, FilterBlocState> {
  final Filter initialFilter;

  FilterBloc({this.initialFilter});

  @override
  FilterBlocState get initialState =>
      FilterBlocState(filter: initialFilter ?? Filter());

  @override
  Stream<FilterBlocState> mapEventToState(FilterBlocEvent event) async* {
    yield* event.map(
      changeOpeningHour: _mapChangeOpeningHour,
      changeOrdering: _mapChangeOrdering,
      changeTags: _mapChangeTags,
    );
  }

  Stream<FilterBlocState> _mapChangeOpeningHour(
      ChangeOpeningHour event) async* {
    yield FilterBlocState(filter: state.filter.copyWith(onlyOpen: event.open));
  }

  Stream<FilterBlocState> _mapChangeOrdering(ChangeOrdering event) async* {
    yield FilterBlocState(
        filter: state.filter.copyWith(ordering: event.ordering));
  }

  Stream<FilterBlocState> _mapChangeTags(ChangeTags event) async* {
    yield FilterBlocState(
      filter:
          state.filter.copyWith(tagIds: event.tags.map((t) => t.id).toList()),
    );
  }
}
