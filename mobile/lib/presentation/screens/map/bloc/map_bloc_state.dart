import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/cafe.dart';
import '../../../../domain/entities/location.dart';

part 'map_bloc_state.freezed.dart';

@freezed
abstract class MapBlocState with _$MapBlocState {
  const factory MapBlocState.loading() = Loading;
  const factory MapBlocState.loaded(
      {@required List<Cafe> cafes, @required Location location}) = Loaded;
  const factory MapBlocState.failure(String message) = _Failure;
}