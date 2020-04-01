import 'package:coffee_time/core/app_config.dart';
import 'package:coffee_time/data/services/photo_service.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_helper.dart';

void main() {
  PhotoServiceImpl photoService;

  var appConfig = AppConfig(apiUrl: 'http://www.test.com/api');

  setUp(() {
    noLogger();
    photoService = PhotoServiceImpl(appConfig: appConfig);
  });

  group('getBasePhotoUrl', () {
    test('Should return proper url', () {
      final expectedUrl = '${appConfig.apiUrl}/photo/abc';
      final actual = photoService.getBasePhotoUrl('abc');

      expect(actual, equals(expectedUrl));
    });
  });
}
