import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/tag.dart';
import '../model/tag_review.dart';

part 'tags_review_event.freezed.dart';

@freezed
abstract class TagsReviewBlocEvent with _$TagsReviewBlocEvent {
  const factory TagsReviewBlocEvent.load() = Load;
  const factory TagsReviewBlocEvent.addTags({@required List<Tag> tagsToAdd}) =
      AddTags;
  const factory TagsReviewBlocEvent.removeAdded({@required Tag tagToRemove}) =
      RemovedAdded;
  const factory TagsReviewBlocEvent.reviewTag(
      {@required String id, TagReviewKind review}) = ReviewTag;
}
