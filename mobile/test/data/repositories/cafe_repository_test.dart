import 'package:coffee_time/core/either.dart';
import 'package:coffee_time/data/models/models.dart';
import 'package:coffee_time/data/repositories/cafe.dart';
import 'package:coffee_time/data/services/cafe_service.dart';
import 'package:coffee_time/data/services/favorite_service.dart';
import 'package:coffee_time/data/services/photo_service.dart';
import 'package:coffee_time/domain/entities/cafe_detail.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/domain/exceptions/api.dart';
import 'package:coffee_time/domain/failure.dart';
import 'package:coffee_time/domain/repositories/nearby_result.dart';
import 'package:coffee_time/domain/repositories/tags_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_helper.dart';

class MockCafeService extends Mock implements CafeService {}

class MockFavoriteService extends Mock implements FavoriteService {}

class MockPhotoService extends Mock implements PhotoService {}

class MockTagRepository extends Mock implements TagRepository {}

void main() {
  MockCafeService mockCafeService;
  MockPhotoService mockPhotoService;
  MockFavoriteService mockFavoriteService;
  MockTagRepository mockTagRepository;

  CafeRepositoryImpl repository;

  const photoUrl = 'photoUrl';
  Map<String, String> referenceToUrlMap;
  List<Tag> allTags;

  setUp(() {
    mockCafeService = MockCafeService();
    mockPhotoService = MockPhotoService();
    mockFavoriteService = MockFavoriteService();
    mockTagRepository = MockTagRepository();

    repository = CafeRepositoryImpl(
      cafeService: mockCafeService,
      favoriteService: mockFavoriteService,
      photoService: mockPhotoService,
      tagRepository: mockTagRepository,
    );

    final cafeModel = cafeModelExample();
    allTags = [tagExample().toEntity()];
    referenceToUrlMap = {cafeModel.photo.reference: photoUrl};

    final detailModel = cafeModelDetailExample();

    for (final p in detailModel.photos) {
      referenceToUrlMap[p.reference] = photoUrl;
    }

    when(mockFavoriteService.getFavorites(any))
        .thenAnswer((_) async => [cafeModel.placeId]);
    when(
      mockPhotoService.getPhotoUrl(
        any,
        maxHeight: anyNamed('maxHeight'),
        maxWidth: anyNamed('maxWidth'),
      ),
    ).thenReturn(photoUrl);
    when(mockTagRepository.getAll()).thenAnswer((_) async => Left(allTags));
  });

  group('getNearby', () {
    test('When service returns data, should return entities', () async {
      final model = cafeModelExample();

      when(
        mockCafeService.getNearBy(Location(1, 1),
            language: argThat(isInstanceOf<String>(), named: 'language'),
            openNow: anyNamed('openNow'),
            pageToken: anyNamed('pageToken')),
      ).thenAnswer((_) async => NearbyResultModel(cafes: [model]));

      final result = await repository.getNearby(Location(1, 1));

      expect(
          result,
          equals(
            Left<NearbyResult, Failure>(NearbyResult(cafes: [
              model.toEntity(
                  isFavorite: true, allTags: allTags, photoUrl: photoUrl)
            ])),
          ));
    });

    test('When service returns data with token, should return data with token',
        () async {
      final model = cafeModelExample();

      when(
        mockCafeService.getNearBy(Location(1, 1),
            language: argThat(isInstanceOf<String>(), named: 'language'),
            openNow: anyNamed('openNow'),
            pageToken: anyNamed('pageToken')),
      ).thenAnswer(
        (_) async => NearbyResultModel(cafes: [model], nextPageToken: 'token'),
      );

      final result = await repository.getNearby(Location(1, 1));

      expect(
          result,
          equals(
            Left<NearbyResult, Failure>(NearbyResult(cafes: [
              model.toEntity(
                  isFavorite: true, allTags: allTags, photoUrl: photoUrl)
            ], nextPageToken: 'token')),
          ));
    });

    test('When service fails, should return failure', () async {
      when(
        mockCafeService.getNearBy(Location(1, 1),
            language: argThat(isInstanceOf<String>(), named: 'language'),
            openNow: anyNamed('openNow'),
            pageToken: anyNamed('pageToken')),
      ).thenThrow(ApiException(body: 'fail', statusCode: 400));

      final result = await repository.getNearby(Location(1, 1));

      expect(
          result,
          equals(Right<NearbyResult, Failure>(
            ServiceFailure('Call to nearby service failed',
                inner: ApiException(body: 'fail', statusCode: 400)),
          )));
    });

    test('When passed filter, filter is applied', () async {
      final openedCafe = cafeModelExample(openNow: true);

      when(
        mockCafeService.getNearBy(Location(1, 1),
            language: argThat(isInstanceOf<String>(), named: 'language'),
            openNow: anyNamed('openNow'),
            pageToken: anyNamed('pageToken')),
      ).thenAnswer((_) async => NearbyResultModel(cafes: [openedCafe]));

      final result = await repository.getNearby(Location(1, 1),
          filter: Filter(onlyOpen: true));

      expect(
        result,
        equals(Left<NearbyResult, Failure>(NearbyResult(cafes: [
          openedCafe.toEntity(
              isFavorite: true, allTags: allTags, photoUrl: photoUrl)
        ]))),
      );
    });
  });

  group('detail', () {
    test('When service returns data, should return entities', () async {
      final model = cafeModelExample();
      final detailModel = cafeModelDetailExample();
      when(
        mockCafeService.getDetail(
          model.placeId,
          language: argThat(isInstanceOf<String>(), named: 'language'),
        ),
      ).thenAnswer((_) async => detailModel);

      final result = await repository.getDetail(model.placeId);

      expect(
        result,
        equals(
          Left<CafeDetail, Failure>(detailModel.toEntity(referenceToUrlMap)),
        ),
      );
    });

    test('When service failed, should return failure', () async {
      when(
        mockCafeService.getDetail(
          any,
          language: argThat(isInstanceOf<String>(), named: 'language'),
        ),
      ).thenThrow(ApiException(body: 'fail', statusCode: 400));

      final result = await repository.getDetail('123');

      expect(result, isInstanceOf<Right<CafeDetail, Failure>>());
      expect(
        ((result as Right<CafeDetail, Failure>).right as ServiceFailure).inner,
        ApiException(body: 'fail', statusCode: 400),
      );
    });
  });
}
