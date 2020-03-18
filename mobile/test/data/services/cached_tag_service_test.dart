import 'package:coffee_time/core/time_provider.dart';
import 'package:coffee_time/data/services/cached_tag_service.dart';
import 'package:coffee_time/data/services/tag_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_helper.dart';

class MockTimeProvider extends Mock implements TimeProvider {}

class MockTagService extends Mock implements TagService {}

void main() {
  MockTimeProvider mockTimeProvider;
  MockTagService mockTagService;

  setUp(() {
    mockTimeProvider = MockTimeProvider();
    mockTagService = MockTagService();
  });

  group('getAll', () {
    test('For first request should call service', () async {
      when(mockTagService.getAll()).thenAnswer((_) async => [tagExample()]);

      final cachedService = CachedTagService(
        tagService: mockTagService,
        timeProvider: mockTimeProvider,
      );

      final result = await cachedService.getAll();

      verify(mockTagService.getAll()).called(1);
      expect(result, [tagExample()]);
    });

    test('For subsequent requests should not call service again', () async {
      final time = DateTime.now();
      when(mockTagService.getAll()).thenAnswer((_) async => [tagExample()]);
      when(mockTimeProvider.now()).thenReturn(time);

      final cachedService = CachedTagService(
        tagService: mockTagService,
        timeProvider: mockTimeProvider,
      );

      final result = await cachedService.getAll();

      verify(mockTagService.getAll()).called(1);
      expect(result, [tagExample()]);

      await cachedService.getAll();

      verifyNoMoreInteractions(mockTagService);
    });
  });

  group('getForCafe', () {
    test('Always call service', () async {
      when(mockTagService.getForCafe(any))
          .thenAnswer((_) async => [tagReputationExample()]);

      final cachedService = CachedTagService(
        tagService: mockTagService,
        timeProvider: mockTimeProvider,
      );

      final result = await cachedService.getForCafe('123');

      verify(mockTagService.getForCafe('123')).called(1);
      expect(result, [tagReputationExample()]);

      await cachedService.getForCafe('123');
      verify(mockTagService.getForCafe('123')).called(1);
    });
  });
}
