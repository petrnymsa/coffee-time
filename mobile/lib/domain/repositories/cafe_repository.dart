import '../../core/either.dart';
import '../entities/cafe.dart';
import '../entities/cafe_detail.dart';
import '../entities/filter.dart';
import '../entities/location.dart';
import '../entities/tag_update.dart';
import '../failure.dart';
import 'nearby_result.dart';

//todo documentation
abstract class CafeRepository {
  Future<Either<NearbyResult, Failure>> getNearby(Location location,
      {Filter filter, String pageToken});

  Future<Either<List<Cafe>, Failure>> search(String search, {Filter filter});

  Future<Either<List<Cafe>, Failure>> getFavorites();

  Future<Either<CafeDetail, Failure>> getDetail(String id);

  Future<Either<bool, Failure>> toggleFavorite(String id);

  Future<Either<bool, Failure>> updateTagsForCafe(
      String id, List<TagUpdate> updates);
}
