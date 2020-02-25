import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/cafe.dart';

part 'cafelist_state.freezed.dart';

@freezed
abstract class CafeListState with _$CafeListState {
  const factory CafeListState.loading() = Loading;
  const factory CafeListState.loaded(
      {@required List<Cafe> cafes, String nextPage}) = Loaded;
  const factory CafeListState.failure(String message) = _Failure;
}
