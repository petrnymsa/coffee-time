import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/entities/filter.dart';
import '../../../../domain/entities/location.dart';

part 'map_bloc_event.freezed.dart';

@freezed
abstract class MapBlocEvent with _$MapBlocEvent {
  const factory MapBlocEvent.init({@Default(Filter()) Filter filter}) = Init;
  const factory MapBlocEvent.setCurrentLocation(
      {@Default(Filter()) Filter filter}) = SetCurrentLocation;
  const factory MapBlocEvent.setLocation(Location location,
      {@Default(Filter()) Filter filter}) = SetLocation;
}
