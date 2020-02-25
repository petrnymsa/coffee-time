import 'package:coffee_time/domain/repositories/nearby_result.dart';

import '../../core/either.dart';
import '../entities/cafe.dart';
import '../entities/cafe_detail.dart';
import '../entities/filter.dart';
import '../entities/location.dart';
import '../failure.dart';

//todo documentation
abstract class CafeRepository {
  //todo add pagetoken parameter
  Future<Either<NearbyResult, Failure>> getNearby(Location location,
      {Filter filter, String pageToken});

  Future<Either<List<Cafe>, Failure>> search(String search, {Filter filter});

  Future<Either<List<Cafe>, Failure>> getFavorites();

  Future<Either<CafeDetail, Failure>> getDetail(String id);

  Future<Either<Cafe, Failure>> toggleFavorite(Cafe cafe);

  //todo update cafe tags, add TagUpdate entity
  //Future addTags(String cafeId, List<TagReputation> tags);
}
