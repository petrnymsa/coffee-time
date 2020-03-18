import 'package:meta/meta.dart';

import '../../core/app_logger.dart';
import '../../core/either.dart';
import '../../core/locale_provider.dart';
import '../../domain/entities/cafe.dart';
import '../../domain/entities/cafe_detail.dart';
import '../../domain/entities/filter.dart';
import '../../domain/entities/location.dart';
import '../../domain/entities/tag.dart';
import '../../domain/entities/tag_reputation.dart';
import '../../domain/entities/tag_update.dart';
import '../../domain/exceptions/api.dart';
import '../../domain/failure.dart';
import '../../domain/repositories/cafe_repository.dart';
import '../../domain/repositories/nearby_result.dart';
import '../../domain/repositories/tags_repository.dart';
import '../models/tag_update.dart';
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
      final locale = LocaleProvider.getLocaleWithDashFormat();
      final result = await cafeService.getDetail(id, language: locale);

      final photoUrlMap = <String, String>{};
      for (final photo in result.photos) {
        photoUrlMap[photo.reference] =
            photoService.getBasePhotoUrl(photo.reference);
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
  Future<Either<List<Cafe>, Failure>> getFavorites() async {
    try {
      final tags = await _getTags();
      final favoriteIds = await _getFavoriteIds();

      final cafes = <Cafe>[];
      final locale = LocaleProvider.getLocaleWithDashFormat();

      for (final id in favoriteIds) {
        final cafe = await cafeService.getBasicInfo(id, language: locale);
        var photoUrl;

        if (cafe.photo != null) {
          photoUrl = photoService.getBasePhotoUrl(cafe.photo.reference);
        }

        cafes.add(cafe.toEntity(
          isFavorite: true,
          allTags: tags,
          photoUrl: photoUrl,
        ));
      }

      return Left(cafes);
    } on ApiException catch (e) {
      return Right(
          ServiceFailure('Call to basicInfo service failed', inner: e));
    } on GoogleApiException catch (e) {
      return Right(
          ServiceFailure('Call to basicInfo service failed', inner: e));
    } catch (e) {
      return Right(CommonFailure(e));
    }
  }

  @override
  Future<Either<NearbyResult, Failure>> getNearby(Location location,
      {Filter filter = const Filter(), String pageToken}) async {
    try {
      getLogger('CafeRepository').i('getNearby at location: $location');

      final locale = LocaleProvider.getLocaleWithDashFormat();
      final result = await cafeService.getNearBy(
        location,
        language: locale,
        openNow: filter.onlyOpen,
        pageToken: pageToken,
        radius:
            filter.ordering == FilterOrdering.popularity ? filter.radius : null,
      );
      final allTags = await _getTags();
      final favoriteIds = await _getFavoriteIds();

      var cafes = result.cafes.map(
        (x) {
          var photoUrl;
          if (x.photo != null) {
            photoUrl = photoService.getBasePhotoUrl(x.photo.reference);
          }
          return x.toEntity(
            isFavorite: favoriteIds.contains(x.placeId),
            allTags: allTags,
            photoUrl: photoUrl,
          );
        },
      ).toList();

      if (filter.tagIds.isNotEmpty) {
        cafes = cafes
            .where((c) =>
                c.tags.isNotEmpty &&
                c.tags.any((t) => filter.tagIds.contains(t.id)))
            .toList();
      }

      return Left(
          NearbyResult(cafes: cafes, nextPageToken: result.nextPageToken));
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
    throw UnimplementedError();
  }

  @override
  Future<Either<bool, Failure>> toggleFavorite(String cafeId) async {
    try {
      final result =
          await favoriteService.setFavorite('user', cafeId); //todo get User
      return Left(result);
    } catch (e) {
      return Right(CommonFailure(e));
    }
  }

  @override
  Future<Either<List<TagReputation>, Failure>> updateTagsForCafe(
      String id, List<TagUpdate> updates) async {
    try {
      final updateModels = updates
          .map((x) => TagUpdateModel(id: x.id, change: x.change))
          .toList();

      await cafeService.updateTagsForCafe(id, updateModels);

      final tagsResult = await tagRepository.getForCafe(id);

      return tagsResult.when(
        left: (tags) => Left(tags),
        right: (failure) => Right(failure),
      );
    } on ApiException catch (e) {
      return Right(ServiceFailure('Call to update tags failed', inner: e));
    } catch (e) {
      return Right(CommonFailure(e));
    }
  }
}
