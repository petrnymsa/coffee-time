import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FilterEntity.apply', () {
    test('Given default filter, only opened cafe can apply', () {
      final filter = FilterEntity();
      final cafes = [
        CafeEntity(openNow: true, tags: []),
        CafeEntity(openNow: false, tags: []),
        CafeEntity(openNow: false, tags: [])
      ];

      final List<bool> results = [];
      cafes.forEach((c) => results.add(filter.apply(c)));

      expect(results, [true, false, false]);
    });

    test('Given onlyOpen=false, all cafes can apply', () {
      final filter = FilterEntity(onlyOpen: false);
      final cafes = [
        CafeEntity(openNow: true, tags: []),
        CafeEntity(openNow: false, tags: []),
        CafeEntity(openNow: false, tags: [])
      ];

      final List<bool> results = [];
      cafes.forEach((c) => results.add(filter.apply(c)));

      expect(results, [true, true, true]);
    });

    test(
        'Given tags to filter and onlyOpen=true, only cafes with given tag should apply',
        () {
      final tags = [
        TagEntity(title: 'a'),
        TagEntity(title: 'b'),
        TagEntity(title: 'c')
      ];
      final filter = FilterEntity(tags: [tags[0], tags[1]]);
      final cafes = [
        CafeEntity(openNow: true, tags: [tags[2], tags[0]]),
        CafeEntity(openNow: true, tags: [tags[2]]),
        CafeEntity(openNow: false, tags: tags)
      ];

      final List<bool> results = [];
      cafes.forEach((c) => results.add(filter.apply(c)));

      expect(results, [true, false, false]);
    });
  });
}
