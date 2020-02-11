import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/cafe_detail.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/domain/entities/tag_reputation.dart';

//todo totally rewrite this ==> get rid of it
abstract class CafeRepository {
  Future<List<Cafe>> getByLocation(Location location, {Filter filter});
  Future<List<Cafe>> getBySearch(String search, {Filter filter});
  Future<List<Cafe>> getFavorites();
  Future<CafeDetail> getDetail(String id);
  Future<List<Tag>> getAllTags();

  Future<bool> toggleFavorite(Cafe entity);
  Future addTags(Cafe entity, List<TagReputation> tags);
}
