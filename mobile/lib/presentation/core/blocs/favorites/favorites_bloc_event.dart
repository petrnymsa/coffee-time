import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorites_bloc_event.freezed.dart';

@freezed
abstract class FavoritesBlocEvent with _$FavoritesBlocEvent {
  const factory FavoritesBlocEvent.load() = Load;
  const factory FavoritesBlocEvent.toggleFavorite(String id) = ToggleFavorite;
}
