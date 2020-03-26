import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/cafe.dart';

part 'favorites_bloc_state.freezed.dart';

@freezed
abstract class FavoritesBlocState with _$FavoritesBlocState {
  const factory FavoritesBlocState.loading() = Loading;
  const factory FavoritesBlocState.loaded(
      {@required List<Cafe> cafes,
      String lastCafeId,
      bool lastCafeIsFavorite}) = Loaded;
  const factory FavoritesBlocState.failure(String message) = _Failure;
}
