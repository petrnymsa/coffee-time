import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_time/core/either.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/domain/entities/tag_update.dart';
import 'package:coffee_time/domain/repositories/tags_repository.dart';
import 'package:coffee_time/presentation/screens/tags_review/bloc/bloc.dart';
import 'package:coffee_time/presentation/screens/tags_review/model/tag_review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_helper.dart';

class MockTagRepository extends Mock implements TagRepository {}

//ignore_for_file: avoid_types_on_closure_parameters
void main() {
  final tagsToReview = <Tag>[tagEntityExample()];
  final tagId = tagEntityExample().id;
  final allTags = <Tag>[
    tagEntityExample(),
    Tag(id: '1', title: 't1', icon: Icons.message),
    Tag(id: '2', title: 't2', icon: Icons.message),
    Tag(id: '3', title: 't3', icon: Icons.message)
  ];

  MockTagRepository mockTagRepository;

  setUp(() {
    mockTagRepository = MockTagRepository();
    when(mockTagRepository.getAll()).thenAnswer((_) async => Left(allTags));
  });

  List<Tag> notAdded(List<Tag> present) {
    return allTags.where((t) => !present.contains(t)).toList();
  }

  final initialLoaded = Loaded(
      addedTags: [],
      notAddedYet: notAdded([...tagsToReview]),
      reviews: [
        TagReview(review: TagReviewKind.none, tag: tagEntityExample())
      ]);

  TagsReviewBloc createBloc({bool emitLoad = true}) {
    final bloc = TagsReviewBloc(
      tagRepository: mockTagRepository,
      tagsToReview: tagsToReview,
    );

    if (emitLoad) bloc.add(Load());

    return bloc;
  }

  blocTest(
    'initial state',
    build: () async => createBloc(emitLoad: false),
    skip: 1,
    act: (TagsReviewBloc bloc) async => bloc.add(Load()),
    expect: [initialLoaded],
  );

  blocTest(
    'review tag',
    build: () async => createBloc(),
    act: (TagsReviewBloc bloc) async =>
        bloc.add(ReviewTag(id: tagId, review: TagReviewKind.like)),
    expect: [
      initialLoaded,
      Loaded(addedTags: [], reviews: [
        TagReview(review: TagReviewKind.like, tag: tagEntityExample())
      ], notAddedYet: notAdded(tagsToReview))
    ],
  );

  blocTest(
    'review tag twice',
    build: () async => createBloc(),
    act: (TagsReviewBloc bloc) async {
      bloc.add(ReviewTag(id: tagId, review: TagReviewKind.like));
      bloc.add(ReviewTag(id: tagId, review: TagReviewKind.like));
    },
    expect: [
      initialLoaded,
      Loaded(addedTags: [], reviews: [
        TagReview(review: TagReviewKind.like, tag: tagEntityExample())
      ], notAddedYet: notAdded(tagsToReview)),
      Loaded(addedTags: [], reviews: [
        TagReview(review: TagReviewKind.none, tag: tagEntityExample())
      ], notAddedYet: notAdded(tagsToReview))
    ],
  );

  test('get updates with no review', () {
    final bloc = TagsReviewBloc(
        tagRepository: mockTagRepository, tagsToReview: tagsToReview);
    final result = bloc.getUpdates();

    expect(result, []);
  });

  blocTest(
    'get updates with review',
    build: () async => createBloc(),
    act: (TagsReviewBloc bloc) async =>
        bloc.add(ReviewTag(id: tagId, review: TagReviewKind.like)),
    expect: [
      initialLoaded,
      Loaded(
        addedTags: [],
        reviews: [
          TagReview(review: TagReviewKind.like, tag: tagEntityExample())
        ],
        notAddedYet: notAdded(tagsToReview),
      )
    ],
    verify: (TagsReviewBloc bloc) async {
      final result = bloc.getUpdates();

      expect(result, [TagUpdate(id: tagId, change: TagUpdateKind.like)]);
    },
  );

  blocTest(
    'add tags event',
    build: () async => createBloc(),
    act: (TagsReviewBloc bloc) async =>
        bloc.add(AddTags(tagsToAdd: [allTags[1]])),
    expect: [
      initialLoaded,
      Loaded(
        addedTags: [allTags[1]],
        reviews: [
          TagReview(review: TagReviewKind.none, tag: tagEntityExample())
        ],
        notAddedYet: notAdded([...tagsToReview, allTags[1]]),
      )
    ],
  );
}
