import 'package:coffee_time/core/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/tag.dart';
import '../../../../domain/entities/tag_update.dart';
import '../../../../domain/repositories/tags_repository.dart';
import '../model/tag_review.dart';
import 'tags_review_event.dart';
import 'tags_review_state.dart';

class TagsReviewBloc extends Bloc<TagsReviewBlocEvent, TagsReviewBlocState> {
  final List<Tag> tagsToReview;
  final TagRepository tagRepository;

  TagsReviewBloc({
    @required this.tagsToReview,
    @required this.tagRepository,
  });

  @override
  TagsReviewBlocState get initialState => Loading();

  @override
  Stream<TagsReviewBlocState> mapEventToState(
      TagsReviewBlocEvent event) async* {
    yield* event.map(
      load: _mapLoad,
      addTags: _mapAddTags,
      reviewTag: _mapReviewTag,
    );
  }

  Stream<TagsReviewBlocState> _mapLoad(Load event) async* {
    final result = await tagRepository.getAll();

    yield result.when(left: (tags) {
      final notAdded = tags.where((t) => !tagsToReview.contains(t)).toList();

      return Loaded(
        reviews: tagsToReview
            .map((x) => TagReview(tag: x, review: TagReviewKind.none))
            .toList(),
        addedTags: <Tag>[],
        notAddedYet: notAdded,
      );
    }, right: (failure) {
      //todo failure
      getLogger('TagsReviewBloc').e(failure.toString());
      return null;
    });
  }

  Stream<TagsReviewBlocState> _mapAddTags(AddTags event) async* {
    yield state.maybeMap(
      loaded: (loaded) {
        return Loaded(
          addedTags: [...loaded.addedTags, ...event.tagsToAdd],
          reviews: loaded.reviews,
          notAddedYet: loaded.notAddedYet
              .where((x) => !event.tagsToAdd.contains(x))
              .toList(),
        );
      },
      orElse: () => null, //todo failure
    );
  }

  Stream<TagsReviewBlocState> _mapReviewTag(ReviewTag event) async* {
    yield state.maybeWhen(
        orElse: () => null,
        loaded: (addedTags, reviews, notAddedYet) {
          return Loaded(
              addedTags: addedTags,
              notAddedYet: notAddedYet,
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
        loaded: (addedTags, reviews, notAddedYet) {
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
