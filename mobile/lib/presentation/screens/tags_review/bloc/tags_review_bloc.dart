import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/tag.dart';
import 'tags_review_event.dart';
import 'tags_review_state.dart';

class TagsReviewBloc extends Bloc<TagsReviewBlocEvent, TagsReviewBlocState> {
  final List<Tag> originalTags;

  TagsReviewBloc(this.originalTags);

  @override
  TagsReviewBlocState get initialState => Loading();

  @override
  Stream<TagsReviewBlocState> mapEventToState(
      TagsReviewBlocEvent event) async* {
    yield* event.map(
      addTag: _mapAddTag,
      reviewTag: _mapReviewTag,
    );
  }

  Stream<TagsReviewBlocState> _mapAddTag(AddTag event) {}
  Stream<TagsReviewBlocState> _mapReviewTag(ReviewTag event) {}
}
