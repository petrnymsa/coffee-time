import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/filter.dart';
import '../../../../domain/entities/tag_reputation.dart';

part 'cafelist_event.freezed.dart';

@freezed
abstract class CafeListEvent with _$CafeListEvent {
  const factory CafeListEvent.loadNext(
      {String pageToken, @Default(Filter()) Filter filter}) = LoadNext;
  const factory CafeListEvent.refresh({@Default(Filter()) Filter filter}) =
      Refresh;
  const factory CafeListEvent.setFavorite(
      {@required String cafeId, @required bool isFavorite}) = SetFavorite;
  const factory CafeListEvent.updateTags(
      {@required String cafeId,
      @required List<TagReputation> tags}) = UpdateTags;
}
