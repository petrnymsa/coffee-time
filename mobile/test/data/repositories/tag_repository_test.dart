import 'package:coffee_time/core/either.dart';
import 'package:coffee_time/data/repositories/tag_repository.dart';
import 'package:coffee_time/data/services/tag_service.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/domain/entities/tag_reputation.dart';
import 'package:coffee_time/domain/exceptions/api.dart';
import 'package:coffee_time/domain/failure.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_helper.dart';

class MockTagService extends Mock implements TagService {}

void main() {
  MockTagService mockService;
  TagRepositoryImpl repository;

  setUp(() {
    noLogger();
    mockService = MockTagService();
    repository = TagRepositoryImpl(tagService: mockService);
  });

  group('getAll', () {
    test('When service returns data, should return tags', () async {
      when(mockService.getAll()).thenAnswer((_) async => [tagExample()]);

      final result = await repository.getAll();

      expect(result, Left([tagExample().toEntity()]));
    });

    test('When service returns no tags, should return empty list', () async {
      when(mockService.getAll()).thenAnswer((_) async => []);

      final result = await repository.getAll();

      expect(result, Left([]));
    });

    test('When service throws ApiException, should return ServiceFailure',
        () async {
      when(mockService.getAll())
          .thenThrow(ApiException(body: 'test', statusCode: 400));

      final result = await repository.getAll();

      expect(
          result,
          Right<List<Tag>, Failure>(ServiceFailure(
              TagRepositoryImpl.serviceFailedMessage,
              inner: ApiException(body: 'test', statusCode: 400))));
    });

    test('When service throws Exception, should return CommonFailure',
        () async {
      final exception = Exception('generic');
      when(mockService.getAll()).thenThrow(exception);

      final result = await repository.getAll();

      expect(result, Right<List<Tag>, Failure>(CommonFailure(exception)));
    });
  });

  group('getById', () {
    test('When found, should return tag', () async {
      when(mockService.getAll()).thenAnswer((_) async => [tagExample()]);

      final result = await repository.getById(tagExample().id);

      expect(result, Left(tagExample().toEntity()));
    });

    test('When not found, should return NotFound failure', () async {
      when(mockService.getAll()).thenAnswer((_) async => []);

      final result = await repository.getById(tagExample().id);

      expect(result, Right<Tag, Failure>(NotFound()));
    });

    test('When service throws api exception, should return service failure',
        () async {
      when(mockService.getAll())
          .thenThrow(ApiException(body: 'test', statusCode: 400));

      final result = await repository.getById('abc');

      expect(
          result,
          Right<Tag, Failure>(ServiceFailure(
              TagRepositoryImpl.serviceFailedMessage,
              inner: ApiException(body: 'test', statusCode: 400))));
    });

    test('When service throws generic exception, should return common failure',
        () async {
      final exception = Exception('test');
      when(mockService.getAll()).thenThrow(exception);

      final result = await repository.getById('abc');

      expect(result, Right<Tag, Failure>(CommonFailure(exception)));
    });
  });

  group('getForCafe', () {
    test('When data found, should return tags', () async {
      final placeId = 'abc';
      when(mockService.getAll()).thenAnswer((_) async => [tagExample()]);
      when(mockService.getForCafe(placeId))
          .thenAnswer((_) async => [tagReputationExample()]);

      final result = await repository.getForCafe(placeId);

      expect(result,
          Left([tagReputationExample().toEntity(tagExample().toEntity())]));
    });

    test('When no tags found, should return empty list', () async {
      when(mockService.getAll()).thenAnswer((_) async => [tagExample()]);
      when(mockService.getForCafe(any)).thenAnswer((_) async => []);

      final result = await repository.getForCafe('abc');

      expect(result, Left([]));
    });

    test('When service throws api exception, should return service failure',
        () async {
      when(mockService.getAll()).thenAnswer((_) async => [tagExample()]);
      when(mockService.getForCafe(any))
          .thenThrow(ApiException(body: 'test', statusCode: 400));

      final result = await repository.getForCafe('abc');

      expect(
          result,
          Right<List<TagReputation>, Failure>(ServiceFailure(
              TagRepositoryImpl.serviceFailedMessage,
              inner: ApiException(body: 'test', statusCode: 400))));
    });

    test('When service throws generic exception, should return common failure',
        () async {
      final exception = Exception('test');
      when(mockService.getAll()).thenAnswer((_) async => [tagExample()]);
      when(mockService.getForCafe(any)).thenThrow(exception);

      final result = await repository.getForCafe('abc');

      expect(result,
          Right<List<TagReputation>, Failure>(CommonFailure(exception)));
    });
  });
}
