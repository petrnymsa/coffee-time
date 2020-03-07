import 'package:coffee_time/data/services/api_base.dart';
import 'package:coffee_time/data/services/photo_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_helper.dart';

PhotoServiceImpl photoService;

void main() {
  setUp(() {
    noLogger();
    photoService = PhotoServiceImpl();
  });

  group('getBasePhotoUrl', () {
    test('Should return proper url', () {
      final expectedUrl = '${ApiBase.apiBaseUrl}/photo/abc';
      final actual = photoService.getBasePhotoUrl('abc');

      expect(actual, equals(expectedUrl));
    });
  });
}
