import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/filter.dart';
import '../../../../domain/entities/tag.dart';

part 'filter_bloc_event.freezed.dart';

@freezed
abstract class FilterBlocEvent with _$FilterBlocEvent {
  const factory FilterBlocEvent.changeOpeningHour({@required bool open}) =
      ChangeOpeningHour;
  const factory FilterBlocEvent.changeOrdering(
      {@required FilterOrdering ordering}) = ChangeOrdering;
  const factory FilterBlocEvent.changeTags({@required List<Tag> tags}) =
      ChangeTags;
}
