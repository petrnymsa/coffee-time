import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_time/data/repositories/mock/tag_repository.dart';
import 'package:coffee_time/data/repositories/mock/tags_data_source.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/domain/entities/tag_update.dart';
import 'package:coffee_time/presentation/screens/tags_review/bloc/bloc.dart';
import 'package:coffee_time/presentation/screens/tags_review/model/tag_review.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_helper.dart';

//ignore_for_file: avoid_types_on_closure_parameters
void main() {
  final tagsToReview = <Tag>[tagEntityExample()];
  final tagId = tagsToReview[0].id;

  final dataSource = MockTagsDataSource();

  List<Tag> notAdded(List<Tag> present) {
    final all = dataSource.tags;

    return all.where((t) => !present.contains(t)).toList();
  }

  final initialLoaded = Loaded(
      addedTags: [],
      notAddedYet: notAdded([]),
      reviews: [
        TagReview(review: TagReviewKind.none, tag: tagEntityExample())
      ]);

  TagsReviewBloc createBloc() {
    return TagsReviewBloc(
      tagRepository: MockedTagRepository(),
      tagsToReview: tagsToReview,
    )..add(Load());
  }

  blocTest(
    'initial state',
    build: () async => TagsReviewBloc(
      tagRepository: MockedTagRepository(),
      tagsToReview: tagsToReview,
    ),
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
        tagRepository: MockedTagRepository(), tagsToReview: tagsToReview);
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
}
