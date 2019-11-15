import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/cafe_detail.dart';
import 'package:coffee_time/domain/entities/location.dart';

abstract class CafeRepository {
  Future<List<CafeEntity>> getByLocation(LocationEntity location);
  Future<List<CafeEntity>> getBySearch(String search);
  Future<List<CafeEntity>> getFavorites();
  Future<CafeDetailEntity> getDetail(String id);

  Future<bool> updateEntity(CafeEntity entity);
}
