import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/cafe.dart';

part 'favorites_bloc_state.freezed.dart';

@freezed
abstract class FavoritesBlocState with _$FavoritesBlocState {
  const factory FavoritesBlocState.loading() = Loading;
  const factory FavoritesBlocState.loaded(List<Cafe> cafes) = Loaded;
  const factory FavoritesBlocState.failure(String message) = _Failure;
}
