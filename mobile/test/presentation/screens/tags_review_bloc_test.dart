import 'package:bloc_test/bloc_test.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/domain/entities/tag_update.dart';
import 'package:coffee_time/presentation/screens/tags_review/bloc/bloc.dart';
import 'package:coffee_time/presentation/screens/tags_review/model/tag_review.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_helper.dart';

//ignore_for_file: avoid_types_on_closure_parameters
void main() {
  final tags = <Tag>[tagEntityExample()];
  final tagId = tags[0].id;
  blocTest(
    'initial state',
    build: () async => TagsReviewBloc(tags),
    skip: 0,
    expect: [
      Loaded(addedTags: [], reviews: [
        TagReview(review: TagReviewKind.none, tag: tagEntityExample())
      ])
    ],
  );

  blocTest(
    'review tag',
    build: () async => TagsReviewBloc(tags),
    act: (TagsReviewBloc bloc) async =>
        bloc.add(ReviewTag(id: tagId, review: TagReviewKind.like)),
    expect: [
      Loaded(addedTags: [], reviews: [
        TagReview(review: TagReviewKind.like, tag: tagEntityExample())
      ])
    ],
  );

  test('get updates with no review', () {
    final bloc = TagsReviewBloc(tags);
    final result = bloc.getUpdates();

    expect(result, []);
  });

  blocTest('get updates with review',
      build: () async => TagsReviewBloc(tags),
      act: (TagsReviewBloc bloc) async =>
          bloc.add(ReviewTag(id: tagId, review: TagReviewKind.like)),
      expect: [
        Loaded(addedTags: [], reviews: [
          TagReview(review: TagReviewKind.like, tag: tagEntityExample())
        ])
      ],
      verify: (TagsReviewBloc bloc) async {
        final result = bloc.getUpdates();

        expect(result, [TagUpdate(id: tagId, change: TagUpdateKind.like)]);
      });
}
