import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/cafe.dart';
import '../../../../domain/entities/filter.dart';
import '../../../../domain/entities/location.dart';

part 'cafelist_state.freezed.dart';

@freezed
abstract class CafeListState with _$CafeListState {
  const factory CafeListState.loading() = Loading;
  const factory CafeListState.loaded({
    @required List<Cafe> cafes,
    @required Filter actualFilter,
    @required Location currentLocation,
    String nextPageToken,
  }) = Loaded;
  const factory CafeListState.failure(String message) = _Failure;
  const factory CafeListState.failureNoLocationService() =
      FailureNoLocationService;
  const factory CafeListState.failureNoLocationPermission() =
      FailureNoLocationPermission;
}
