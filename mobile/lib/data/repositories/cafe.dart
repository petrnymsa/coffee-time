import 'package:meta/meta.dart';

import '../../core/either.dart';
import '../../domain/entities/cafe.dart';
import '../../domain/entities/cafe_detail.dart';
import '../../domain/entities/filter.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/tag.dart';
import '../../domain/exceptions/api.dart';
import '../../domain/failure.dart';
import '../../domain/repositories/cafe_repository.dart';
import '../../domain/repositories/tags_repository.dart';
import '../services/cafe_service.dart';
import '../services/favorite_service.dart';
import '../services/photo_service.dart';

//ignore_for_file: avoid_catches_without_on_clauses
class CafeRepositoryImpl implements CafeRepository {
  final CafeService cafeService;
  final FavoriteService favoriteService;
  final PhotoService photoService;
  final TagRepository tagRepository;

  CafeRepositoryImpl({
    @required this.cafeService,
    @required this.favoriteService,
    @required this.photoService,
    @required this.tagRepository,
  });

  Future<List<Tag>> _getTags() async {
    final result = await tagRepository.getAll();

    return result.when(
      left: (data) => data,
      right: (failure) => failure.maybeWhen(
        (d) => throw d,
        serviceFailure: (msg, inner) => throw inner,
        orElse: () => throw Exception("Unexpected error"),
      ),
    );
  }

  Future<List<String>> _getFavoriteIds() async {
    //todo getUserId
    return favoriteService.getFavorites('user');
  }

  @override
  Future<Either<CafeDetail, Failure>> getDetail(String id) async {
    try {
      //todo get language
      final result = await cafeService.getDetail(id, language: 'en-US');

      final photoUrlMap = <String, String>{};
      for (final photo in result.photos) {
        photoUrlMap[photo.reference] = photoService.getPhotoUrl(
          photo.reference,
          maxHeight: photo.height,
          maxWidth: photo.width,
        );
      }
      return Left(result.toEntity(photoUrlMap));
    } on ApiException catch (e) {
      return Right(ServiceFailure('Call to detail service failed', inner: e));
    } on GoogleApiException catch (e) {
      return Right(ServiceFailure('Call to detail service failed', inner: e));
    } catch (e) {
      return Right(CommonFailure(e));
    }
  }

  @override
  Future<Either<List<Cafe>, Failure>> getFavorites() {
    // todo: implement getFavorites
    return null;
  }

  @override
  Future<Either<List<Cafe>, Failure>> getNearby(Location location,
      {Filter filter = const Filter()}) async {
    try {
      //todo handle errors

      //todo get current language
      //todo apply filter - tags
      //todo apply filter - ordering

      final result = await cafeService.getNearBy(
        location,
        language: 'en-US',
        openNow: filter.onlyOpen,
      );

      // todo get isFavorite
      final tags = await _getTags();
      final favoriteIds = await _getFavoriteIds();

      final cafes = result.map(
        (x) {
          final photoUrl = photoService.getPhotoUrl(x.photo.reference,
              maxWidth: x.photo.width, maxHeight: x.photo.height);
          return x.toEntity(
            isFavorite: favoriteIds.contains(x.placeId),
            allTags: tags,
            photoUrl: photoUrl,
          );
        },
      ).toList();

      return Left(cafes);
    } on ApiException catch (e) {
      return Right(ServiceFailure('Call to nearby service failed', inner: e));
    } on GoogleApiException catch (e) {
      return Right(ServiceFailure('Call to nearby service failed', inner: e));
    } catch (e) {
      return Right(CommonFailure(e));
    }
  }

  @override
  Future<Either<List<Cafe>, Failure>> search(String search, {Filter filter}) {
    // todo: implement search
    return null;
  }

  @override
  Future<Either<Cafe, Failure>> toggleFavorite(Cafe cafe) {
    // todo: implement toggleFavorite
    return null;
  }
}
