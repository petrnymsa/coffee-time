import '../../core/either.dart';
import '../../domain/entities/cafe.dart';
import '../../domain/entities/cafe_detail.dart';
import '../../domain/entities/filter.dart';
import '../../domain/entities/location.dart';
import '../../domain/failure.dart';
import '../../domain/repositories/cafe_repository.dart';
import '../services/cafe_service.dart';

class CafeRepositoryImpl implements CafeRepository {
  final CafeService cafeService;

  CafeRepositoryImpl({this.cafeService});

  @override
  Future<Either<CafeDetail, Failure>> getDetail(String id) {
    // TODO: implement getDetail
    return null;
  }

  @override
  Future<Either<List<Cafe>, Failure>> getFavorites() {
    // TODO: implement getFavorites
    return null;
  }

  @override
  Future<Either<List<Cafe>, Failure>> getNearby(Location location,
      {Filter filter}) async {
    //todo get current language
    final result = await cafeService.getNearBy(location, language: 'en-US');

    //todo map tags
    // todo get photoUrl
    // todo get isFavorite
    final cafes = result
        .map((x) => x.toEntity(isFavorite: false, allTags: [], photoUrl: null))
        .toList();
    return Left(cafes);
  }

  @override
  Future<Either<List<Cafe>, Failure>> search(String search, {Filter filter}) {
    // TODO: implement search
    return null;
  }

  @override
  Future<Either<Cafe, Failure>> toggleFavorite(Cafe cafe) {
    // TODO: implement toggleFavorite
    return null;
  }
}
