import '../../core/either.dart';
import '../entities/cafe.dart';
import '../entities/cafe_detail.dart';
import '../entities/filter.dart';
import '../entities/location.dart';
import '../failure.dart';

//todo documentation
abstract class CafeRepository {
  Future<Either<List<Cafe>, Failure>> getNearby(Location location,
      {Filter filter});

  Future<Either<List<Cafe>, Failure>> search(String search, {Filter filter});

  Future<Either<List<Cafe>, Failure>> getFavorites();

  Future<Either<CafeDetail, Failure>> getDetail(String id);

  Future<Either<Cafe, Failure>> toggleFavorite(Cafe cafe);

  //todo update cafe tags, add TagUpdate entity
  //Future addTags(String cafeId, List<TagReputation> tags);
}
