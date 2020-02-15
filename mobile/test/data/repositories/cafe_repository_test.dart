import 'package:coffee_time/core/either.dart';
import 'package:coffee_time/data/repositories/cafe.dart';
import 'package:coffee_time/data/services/cafe_service.dart';
import 'package:coffee_time/data/services/favorite_service.dart';
import 'package:coffee_time/data/services/photo_service.dart';
import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/cafe_detail.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/domain/exceptions/api.dart';
import 'package:coffee_time/domain/failure.dart';
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

    final cafeModel = cafeExample();
    allTags = [tagExample().toEntity()];
    referenceToUrlMap = {cafeModel.photo.reference: photoUrl};

    final detailModel = cafeDetailExample();

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
      final model = cafeExample();

      when(
        mockCafeService.getNearBy(Location(1, 1),
            language: argThat(isInstanceOf<String>(), named: 'language'),
            openNow: anyNamed('openNow'),
            pageToken: anyNamed('pageToken')),
      ).thenAnswer((_) async => [model]);

      final result = await repository.getNearby(Location(1, 1));

      expect(
          result,
          equals(Left<List<Cafe>, Failure>([
            model.toEntity(
                isFavorite: false, allTags: allTags, photoUrl: photoUrl)
          ])));
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
          equals(Right<List<Cafe>, Failure>(
            ServiceFailure('Call to nearby service failed',
                inner: ApiException(body: 'fail', statusCode: 400)),
          )));
    });

    test('When passed filter, filter is applied', () async {
      final openedCafe = cafeExample(openNow: true);

      when(
        mockCafeService.getNearBy(Location(1, 1),
            language: argThat(isInstanceOf<String>(), named: 'language'),
            openNow: anyNamed('openNow'),
            pageToken: anyNamed('pageToken')),
      ).thenAnswer((_) async => [openedCafe]);

      final result = await repository.getNearby(Location(1, 1),
          filter: Filter(onlyOpen: true));

      expect(
          result,
          equals(Left<List<Cafe>, Failure>([
            openedCafe.toEntity(
                isFavorite: false, allTags: allTags, photoUrl: photoUrl)
          ])));
    });
  });

  group('detail', () {
    test('When service returns data, should return entities', () async {
      final model = cafeExample();
      final detailModel = cafeDetailExample();
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
