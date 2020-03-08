import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/tag.dart';

part 'tags_choose_event.freezed.dart';

@freezed
abstract class TagsChooseBlocEvent with _$TagsChooseBlocEvent {
  const factory TagsChooseBlocEvent.chooseTag({@required Tag tag}) = ChooseTag;
}
