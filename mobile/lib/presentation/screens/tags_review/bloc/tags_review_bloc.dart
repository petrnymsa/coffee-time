import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/tag.dart';
import '../../../../domain/entities/tag_update.dart';
import '../model/tag_review.dart';
import 'tags_review_event.dart';
import 'tags_review_state.dart';

class TagsReviewBloc extends Bloc<TagsReviewBlocEvent, TagsReviewBlocState> {
  final List<Tag> originalTags;

  TagsReviewBloc(this.originalTags);

  @override
  TagsReviewBlocState get initialState => Loaded(
      reviews: originalTags
          .map((x) => TagReview(tag: x, review: TagReviewKind.none))
          .toList(),
      addedTags: <Tag>[]);

  @override
  Stream<TagsReviewBlocState> mapEventToState(
      TagsReviewBlocEvent event) async* {
    yield* event.map(
      addTag: _mapAddTag,
      reviewTag: _mapReviewTag,
    );
  }

  Stream<TagsReviewBlocState> _mapAddTag(AddTag event) async* {}
  Stream<TagsReviewBlocState> _mapReviewTag(ReviewTag event) async* {
    yield state.maybeWhen(
        orElse: () => null,
        loaded: (addedTags, reviews) {
          return Loaded(
              addedTags: addedTags,
              reviews: reviews.map((x) {
                if (x.tag.id == event.id) {
                  if (x.review == event.review) {
                    event = event.copyWith(review: TagReviewKind.none);
                  }
                  return TagReview(tag: x.tag, review: event.review);
                }
                return x;
              }).toList());
        });
  }

  List<TagUpdate> getUpdates() {
    return state.maybeWhen(
        orElse: () => [],
        loaded: (addedTags, reviews) {
          final reviewUpdates = <TagUpdate>[];

          for (final review in reviews) {
            if (review.review == TagReviewKind.like) {
              reviewUpdates.add(
                  TagUpdate(id: review.tag.id, change: TagUpdateKind.like));
            } else if (review.review == TagReviewKind.dislike) {
              reviewUpdates.add(
                  TagUpdate(id: review.tag.id, change: TagUpdateKind.dislike));
            }
          }

          return [
            ...addedTags
                .map((x) => TagUpdate(id: x.id, change: TagUpdateKind.like)),
            ...reviewUpdates
          ];
        });
  }
}
