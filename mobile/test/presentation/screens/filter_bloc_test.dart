import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_time/core/either.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/domain/repositories/tags_repository.dart';
import 'package:coffee_time/presentation/core/blocs/filter/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockTagRepository extends Mock implements TagRepository {}

void main() {
  MockTagRepository tagRepository;
  final allTags = [
    Tag(id: '1', icon: Icons.filter, title: '1'),
    Tag(id: '2', icon: Icons.filter, title: '2'),
  ];

  setUp(() {
    tagRepository = MockTagRepository();
    when(tagRepository.getAll()).thenAnswer((_) async => Left(allTags));
  });

  FilterBloc createBloc(Filter filter) =>
      FilterBloc(tagRepository: tagRepository, initialFilter: filter);

  blocTest(
    'Change opening hours',
    build: () async => createBloc(Filter(onlyOpen: false)),
    act: (bloc) async => bloc.add(ChangeOpeningHour()),
    expect: [FilterBlocState(filter: Filter(onlyOpen: true))],
  );

  blocTest(
    'Change ordering',
    build: () async => createBloc(Filter(ordering: FilterOrdering.distance)),
    act: (bloc) async => bloc.add(ChangeOrdering()),
    expect: [
      FilterBlocState(filter: Filter(ordering: FilterOrdering.popularity))
    ],
  );

  blocTest(
    'Init with empty filter',
    build: () async => createBloc(Filter(tagIds: [])),
    act: (bloc) async {
      bloc.add(Init());
    },
    expect: [
      FilterBlocState(
          filter: Filter(tagIds: []), addedTags: [], notAddedTags: allTags),
    ],
  );

  blocTest(
    'Init with tags',
    build: () async => createBloc(Filter(tagIds: ['1'])),
    act: (bloc) async {
      bloc.add(Init());
    },
    expect: [
      FilterBlocState(
        filter: Filter(tagIds: ['1']),
        addedTags: [allTags[0]],
        notAddedTags: [allTags[1]],
      ),
    ],
  );

  blocTest(
    'Add tags',
    build: () async => createBloc(Filter(tagIds: ['1'])),
    act: (bloc) async {
      bloc.add(Init());
      bloc.add(AddTags(tags: [Tag(id: '2', icon: Icons.filter, title: '2')]));
    },
    expect: [
      isA<FilterBlocState>(),
      FilterBlocState(
          filter: Filter(tagIds: ['1', '2']),
          addedTags: allTags,
          notAddedTags: []),
    ],
  );

  blocTest(
    'Remove tag and should be empty',
    build: () async => createBloc(Filter(tagIds: ['1'])),
    act: (bloc) async {
      bloc.add(Init());
      bloc.add(RemoveTag(tagId: '1'));
    },
    expect: [
      isA<FilterBlocState>(),
      FilterBlocState(
          filter: Filter(tagIds: []), addedTags: [], notAddedTags: allTags),
    ],
  );

  blocTest(
    'Remove tag',
    build: () async => createBloc(Filter(tagIds: ['1', '2'])),
    act: (bloc) async {
      bloc.add(Init());
      bloc.add(RemoveTag(tagId: '1'));
    },
    expect: [
      isA<FilterBlocState>(),
      FilterBlocState(
        filter: Filter(tagIds: ['2']),
        addedTags: [allTags[1]],
        notAddedTags: [allTags[0]],
      ),
    ],
  );

  blocTest(
    'Clear tags',
    build: () async => createBloc(Filter(tagIds: ['1', '2'])),
    act: (bloc) async {
      bloc.add(Init());
      bloc.add(ClearTags());
    },
    expect: [
      isA<FilterBlocState>(),
      FilterBlocState(
        filter: Filter(tagIds: []),
        addedTags: [],
        notAddedTags: allTags,
      ),
    ],
  );

  blocTest(
    'Set default',
    build: () async => createBloc(Filter(tagIds: ['123', 'xxx'])),
    act: (bloc) async => bloc.add(SetDefault()),
    expect: [FilterBlocState(filter: Filter())],
  );
}
