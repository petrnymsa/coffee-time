import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/cafe_detail.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/tag.dart';

abstract class CafeRepository {
  Future<List<CafeEntity>> getByLocation(LocationEntity location,
      {FilterEntity filter});
  Future<List<CafeEntity>> getBySearch(String search, {FilterEntity filter});
  Future<List<CafeEntity>> getFavorites();
  Future<CafeDetailEntity> getDetail(String id);
  Future<List<TagEntity>> getAllTags();

  Future<bool> toggleFavorite(CafeEntity entity);
  Future addTags(CafeEntity entity, List<TagEntity> tags);
}
