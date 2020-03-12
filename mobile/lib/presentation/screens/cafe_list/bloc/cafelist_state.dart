import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/cafe.dart';
import '../../../../domain/entities/filter.dart';

part 'cafelist_state.freezed.dart';

@freezed
abstract class CafeListState with _$CafeListState {
  const factory CafeListState.loading() = Loading;
  const factory CafeListState.loaded({
    @required List<Cafe> cafes,
    @required Filter actualFilter,
    String nextPageToken,
  }) = Loaded;
  const factory CafeListState.failure(String message) = _Failure;
}
