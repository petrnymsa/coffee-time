import 'dart:convert';

import 'package:coffee_time/data/services/favorite_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  group('get', () {
    test('For given user data exists, should return list of ids', () async {
      final data = ['a', 'b', 'c'];
      final userId = 'abc';
      SharedPreferences.setMockInitialValues({userId: json.encode(data)});

      final service = FavoriteLocalService();

      final result = await service.getFavorites(userId);

      expect(result, equals(data));
    });

    test('For given user data not exists, should return empty list', () async {
      SharedPreferences.setMockInitialValues({});

      final service = FavoriteLocalService();

      final result = await service.getFavorites('abc');

      expect(result, []);
    });
  });

  group('set', () {
    test('Empty favorites, should write', () async {
      final placeId = 'place';
      final userId = 'abc';
      SharedPreferences.setMockInitialValues({});

      final service = FavoriteLocalService();

      final result = await service.setFavorite(userId, placeId);
      final data = await service.getFavorites(userId);
      expect(result, isTrue);
      expect(data, equals([placeId]));
    });

    test('Existing favorites, should write new one', () async {
      final placeId = 'place';
      final userId = 'abc';
      SharedPreferences.setMockInitialValues({
        userId: json.encode(['foo'])
      });

      final service = FavoriteLocalService();

      final result = await service.setFavorite(userId, placeId);
      final data = await service.getFavorites(userId);
      expect(result, isTrue);
      expect(data, containsAll([placeId, 'foo']));
    });

    test('Existing favorites, should remove existing one', () async {
      final placeId = 'place';
      final userId = 'abc';
      SharedPreferences.setMockInitialValues({
        userId: json.encode([placeId])
      });

      final service = FavoriteLocalService();

      final result = await service.setFavorite(userId, placeId);
      final data = await service.getFavorites(userId);
      expect(result, isFalse);
      expect(data, []);
    });
  });
}
