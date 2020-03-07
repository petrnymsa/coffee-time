import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/tag.dart';
import '../model/tag_review.dart';

part 'tags_review_state.freezed.dart';

@freezed
abstract class TagsReviewBlocState with _$TagsReviewBlocState {
  const factory TagsReviewBlocState.loading() = Loading;
  const factory TagsReviewBlocState.loaded({
    @required List<Tag> addedTags,
    @required List<TagReview> reviews,
  }) = Loaded;
}
