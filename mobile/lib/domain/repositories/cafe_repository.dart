import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/location.dart';

abstract class CafeRepository {
  Future<List<CafeEntity>> getByLocation(LocationEntity location);
}