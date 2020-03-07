import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/tag_update.dart';

part 'tags_review_event.freezed.dart';

@freezed
abstract class TagsReviewBlocEvent with _$TagsReviewBlocEvent {
  const factory TagsReviewBlocEvent.addTag({@required String id}) = AddTag;
  const factory TagsReviewBlocEvent.reviewTag(
      {@required String id, TagUpdateKind updateKind}) = ReviewTag;
}
