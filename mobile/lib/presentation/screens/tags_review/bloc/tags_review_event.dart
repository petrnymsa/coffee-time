import 'package:freezed_annotation/freezed_annotation.dart';

import '../model/tag_review.dart';

part 'tags_review_event.freezed.dart';

@freezed
abstract class TagsReviewBlocEvent with _$TagsReviewBlocEvent {
  const factory TagsReviewBlocEvent.load() = Load;
  const factory TagsReviewBlocEvent.addTag({@required String id}) = AddTag;
  const factory TagsReviewBlocEvent.reviewTag(
      {@required String id, TagReviewKind review}) = ReviewTag;
}
