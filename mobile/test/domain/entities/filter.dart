import 'package:coffee_time/domain/entities/filter.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {});

  group('cafeApplyTags', () {
    test('should return true', () {
      final tags = ['abc', '123'];

      final filter = Filter(tagIds: ['123']);

      final result = filter.filterTags(tags);
      expect(result, isTrue);
    });

    test('should return false', () {
      final tags = ['abc', '123'];

      final filter = Filter(tagIds: ['xxx', 'yyyy']);

      final result = filter.filterTags(tags);
      expect(result, isFalse);
    });
  });
}
