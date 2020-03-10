import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/tag_update.dart';

part 'detail_bloc_event.freezed.dart';

@freezed
abstract class DetailBlocEvent with _$DetailBlocEvent {
  const factory DetailBlocEvent.load() = Load;
  const factory DetailBlocEvent.toggleFavorite(String id) = ToggleFavorite;
  const factory DetailBlocEvent.updateTags(
      {@required String id, @required List<TagUpdate> tags}) = UpdateTags;
}
