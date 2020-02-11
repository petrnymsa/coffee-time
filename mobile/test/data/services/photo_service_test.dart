import 'package:coffee_time/data/services/api_base.dart';
import 'package:coffee_time/data/services/photo_service.dart';
import 'package:flutter_test/flutter_test.dart';

PhotoServiceImpl photoService;

void main() {
  setUp(() {
    photoService = PhotoServiceImpl();
  });

  group('getPhotoUrl', () {
    test('Given only max width should return properly formatted url', () {
      final expectedUrl = '${ApiBase.API_BASE_URL}/photo/abc?maxwidth=300';
      final actual = photoService.getPhotoUrl('abc', maxWidth: 300);

      expect(actual, equals(expectedUrl));
    });

    test('Given only max height should return properly formatted url', () {
      final expectedUrl = '${ApiBase.API_BASE_URL}/photo/abc?maxheight=300';
      final actual = photoService.getPhotoUrl('abc', maxHeight: 300);

      expect(actual, equals(expectedUrl));
    });

    test('Given both height and width should return properly formatted url',
        () {
      final expectedUrl =
          '${ApiBase.API_BASE_URL}/photo/abc?maxwidth=300&maxheight=300';
      final actual =
          photoService.getPhotoUrl('abc', maxHeight: 300, maxWidth: 300);

      expect(actual, equals(expectedUrl));
    });
  });
}
