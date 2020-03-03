import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/cafe.dart';
import '../../../../domain/entities/cafe_detail.dart';

part 'detail_bloc_state.freezed.dart';

@freezed
abstract class DetailBlocState with _$DetailBlocState {
  const factory DetailBlocState.loading() = Loading;
  const factory DetailBlocState.failure(String message) = _Failure;
  const factory DetailBlocState.loaded({Cafe cafe, CafeDetail detail}) = Loaded;
}
