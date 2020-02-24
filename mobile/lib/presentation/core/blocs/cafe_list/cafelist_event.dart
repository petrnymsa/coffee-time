import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/filter.dart';
import '../../../../domain/entities/location.dart';

part 'cafelist_event.freezed.dart';

@freezed
abstract class CafeListEvent with _$CafeListEvent {
  const factory CafeListEvent.loadNearby(Location location) = LoadNearby;
  const factory CafeListEvent.refresh() = Refresh;
  const factory CafeListEvent.loadQuery(Location location) = LoadQuery;
  const factory CafeListEvent.setFilter({@required Filter filter}) = SetFilter;
  //todo favorites
}
