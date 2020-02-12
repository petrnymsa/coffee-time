import 'package:coffee_time/core/either.dart';
import 'package:coffee_time/data/repositories/cafe.dart';
import 'package:coffee_time/data/services/cafe_service.dart';
import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/domain/entities/tag_reputation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../fixtures/fixture_helper.dart';

class MockCafeService extends Mock implements CafeService {}

void main() {
  MockCafeService mockService;
  CafeRepositoryImpl repository;

  setUp(() {
    mockService = MockCafeService();
    repository = CafeRepositoryImpl(cafeService: mockService);
  });

  group('getNearby', () {
    test('When service returns data, should return entities', () async {
      final model = cafeExample();
      when(mockService.getNearBy(Location(1, 1),
              language: argThat(isInstanceOf<String>(), named: 'language')))
          .thenAnswer((_) async => [model]);

      // final result = await repository.getNearby(Location(1, 1));

      // final cafe = Cafe(
      //   name: model.name,
      //   address: model.address,
      //   iconUrl: model.iconUrl,
      //   isFavorite: false,
      //   openNow: model.openNow,
      //   location: model.location.toEntity(),
      //   tags: model.tags.map((t) => t.toEntity(Tag(
      //     id: 'beer',
      //     title: 'beer',
      //     icon: IconData(model.ta)
      //   )))
      // );

      // expect(result, equals(Left([cafeExample()])));

      //todo
    });
  });
}
