import 'package:coffee_time/domain/photo_url_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('getPhotoUrl', () {
    final photoReference = 'abc';
    final baseUrl = 'api/photo/$photoReference';

    test('Given null url should return null', () {
      final actual = createPhotoUrl(null);

      expect(actual, equals(null));
    });

    test('Given no size should throw exception', () {
      expect(() => createPhotoUrl(baseUrl), throwsArgumentError);
    });

    test('Given only max width should return properly formatted url', () {
      final expectedUrl = '$baseUrl?maxwidth=300';
      final actual = createPhotoUrl(baseUrl, maxWidth: 300);

      expect(actual, equals(expectedUrl));
    });

    test('Given only max height should return properly formatted url', () {
      final expectedUrl = '$baseUrl?maxheight=300';
      final actual = createPhotoUrl(baseUrl, maxHeight: 300);

      expect(actual, equals(expectedUrl));
    });

    test('Given both height and width should return properly formatted url',
        () {
      final expectedUrl = '$baseUrl?maxwidth=300&maxheight=300';
      final actual = createPhotoUrl(baseUrl, maxHeight: 300, maxWidth: 300);

      expect(actual, equals(expectedUrl));
    });
  });
}
