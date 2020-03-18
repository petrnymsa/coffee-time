import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/tag.dart';

part 'filter_bloc_event.freezed.dart';

@freezed
abstract class FilterBlocEvent with _$FilterBlocEvent {
  const factory FilterBlocEvent.init() = Init;
  const factory FilterBlocEvent.changeOpeningHour() = ChangeOpeningHour;
  const factory FilterBlocEvent.changeOrdering() = ChangeOrdering;
  const factory FilterBlocEvent.addTags({@required List<Tag> tags}) = AddTags;
  const factory FilterBlocEvent.removeTag({@required String tagId}) = RemoveTag;
  const factory FilterBlocEvent.clearTags() = ClearTags;
  const factory FilterBlocEvent.setDefault() = SetDefault;
}
