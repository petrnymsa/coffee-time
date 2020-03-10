import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/tag.dart';

part 'tags_choose_state.freezed.dart';

@freezed
abstract class TagsChooseBlocState with _$TagsChooseBlocState {
  const factory TagsChooseBlocState.loaded({
    @required List<Tag> chosenTags,
    @required List<Tag> availableTags,
  }) = Loaded;
}
