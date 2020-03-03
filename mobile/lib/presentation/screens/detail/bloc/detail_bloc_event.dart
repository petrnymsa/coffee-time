import 'package:freezed_annotation/freezed_annotation.dart';

part 'detail_bloc_event.freezed.dart';

@freezed
abstract class DetailBlocEvent with _$DetailBlocEvent {
  const factory DetailBlocEvent.load() = Load;
  const factory DetailBlocEvent.toggleFavorite(String id) = ToggleFavorite;
}
