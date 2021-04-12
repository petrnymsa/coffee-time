import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/filter.dart';
import '../../../../domain/entities/tag.dart';
import '../../../../domain/repositories/tags_repository.dart';
import 'filter_bloc_event.dart';
import 'filter_bloc_state.dart';

class FilterBloc extends Bloc<FilterBlocEvent, FilterBlocState> {
  final TagRepository tagRepository;
  final Filter initialFilter;

  FilterBloc({@required this.tagRepository, this.initialFilter})
      : super(FilterBlocState(filter: initialFilter ?? Filter()));

  @override
  Stream<FilterBlocState> mapEventToState(FilterBlocEvent event) async* {
    yield* event.map(
      init: _mapInit,
      confirm: _mapConfirm,
      changeOpeningHour: _mapChangeOpeningHour,
      changeOrdering: _mapChangeOrdering,
      addTags: _mapAddTags,
      removeTag: _mapRemoveTag,
      clearTags: _mapClearTags,
      setDefault: _mapSetDefault,
    );
  }

  Stream<FilterBlocState> _mapInit(Init event) async* {
    final filter = event.filter ?? state.filter;

    final allTagsResult = await tagRepository.getAll();

    final allTags = allTagsResult.when(
      left: (tags) => tags,
      right: (f) => <Tag>[], //todo logger
    );

    final addedTags = <Tag>[];
    final notAddedTags = <Tag>[];

    for (final tag in allTags) {
      if (filter.tagIds.contains(tag.id)) {
        addedTags.add(tag);
      } else {
        notAddedTags.add(tag);
      }
    }

    yield FilterBlocState(
      filter: filter,
      confirmed: false,
      addedTags: addedTags,
      notAddedTags: notAddedTags,
    );
  }

  Stream<FilterBlocState> _mapConfirm(Confirm event) async* {
    yield state.copyWith(confirmed: true);
  }

  Stream<FilterBlocState> _mapChangeOpeningHour(
      ChangeOpeningHour event) async* {
    final filter = state.filter;
    yield state.copyWith(
      filter: filter.copyWith(onlyOpen: !filter.onlyOpen),
      confirmed: false,
    );
  }

  Stream<FilterBlocState> _mapChangeOrdering(ChangeOrdering event) async* {
    final filter = state.filter;
    yield state.copyWith(
      filter: filter.copyWith(ordering: _switchOrdering(filter.ordering)),
      confirmed: false,
    );
  }

  Stream<FilterBlocState> _mapAddTags(AddTags event) async* {
    final addedTags = [...state.addedTags, ...event.tags];
    final addedTagsIds = addedTags.map((x) => x.id).toList();
    final notAddedYet =
        state.notAddedTags.where((t) => !addedTags.contains(t)).toList();

    yield FilterBlocState(
      filter: state.filter.copyWith(tagIds: addedTagsIds),
      addedTags: addedTags,
      notAddedTags: notAddedYet,
      confirmed: false,
    );
  }

  Stream<FilterBlocState> _mapRemoveTag(RemoveTag event) async* {
    final tagToRemove = state.addedTags
        .firstWhere((t) => t.id == event.tagId, orElse: () => null);
    final addedTags =
        state.addedTags.where((t) => t.id != event.tagId).toList();

    final addedTagsIds = addedTags.map((x) => x.id).toList();

    final notAddedYet = [...state.notAddedTags, tagToRemove];
    notAddedYet.sort((a, b) => a.id.compareTo(b.id));

    yield FilterBlocState(
      filter: state.filter.copyWith(tagIds: addedTagsIds),
      addedTags: addedTags,
      notAddedTags: notAddedYet,
      confirmed: false,
    );
  }

  Stream<FilterBlocState> _mapClearTags(ClearTags event) async* {
    final notAdded = [...state.notAddedTags, ...state.addedTags];
    notAdded.sort((a, b) => a.id.compareTo(b.id));

    yield state.copyWith(
      filter: state.filter.copyWith(tagIds: []),
      addedTags: [],
      notAddedTags: notAdded,
      confirmed: false,
    );
  }

  Stream<FilterBlocState> _mapSetDefault(SetDefault event) async* {
    yield state.copyWith(
      filter: Filter(),
      confirmed: false,
    );
  }

  FilterOrdering _switchOrdering(FilterOrdering old) {
    if (old == FilterOrdering.distance) return FilterOrdering.popularity;
    return FilterOrdering.distance;
  }
}
