import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/presentation/screens/filter/bloc/filter_bloc.dart';
import 'package:coffee_time/presentation/screens/filter/bloc/filter_bloc_event.dart';
import 'package:coffee_time/presentation/screens/filter/bloc/filter_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  blocTest(
    'Change opening hours',
    build: () async => FilterBloc(initialFilter: Filter(onlyOpen: false)),
    act: (bloc) async => bloc.add(ChangeOpeningHour(open: true)),
    expect: [FilterBlocState(filter: Filter(onlyOpen: true))],
  );

  blocTest(
    'Change ordering',
    build: () async =>
        FilterBloc(initialFilter: Filter(ordering: FilterOrdering.distance)),
    act: (bloc) async =>
        bloc.add(ChangeOrdering(ordering: FilterOrdering.popularity)),
    expect: [
      FilterBlocState(filter: Filter(ordering: FilterOrdering.popularity))
    ],
  );

  blocTest(
    'Change ordering',
    build: () async =>
        FilterBloc(initialFilter: Filter(ordering: FilterOrdering.distance)),
    act: (bloc) async =>
        bloc.add(ChangeOrdering(ordering: FilterOrdering.popularity)),
    expect: [
      FilterBlocState(filter: Filter(ordering: FilterOrdering.popularity))
    ],
  );

  blocTest(
    'Change tags',
    build: () async =>
        FilterBloc(initialFilter: Filter(tagIds: ['123', 'xxx'])),
    act: (bloc) async => bloc.add(
        ChangeTags(tags: [Tag(id: 'aaa', icon: Icons.filter, title: 'aaa')])),
    expect: [
      FilterBlocState(filter: Filter(tagIds: ['aaa']))
    ],
  );
}
