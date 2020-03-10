import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:flutter_test/flutter_test.dart';

//ignore_for_file: avoid_function_literals_in_foreach_calls
void main() {
  group('FilterEntity.apply', () {
    test('Given default filter, only opened cafe can apply', () {
      final filter = Filter();
      final cafes = [
        Cafe(openNow: true, tags: []),
        Cafe(openNow: false, tags: []),
        Cafe(openNow: false, tags: [])
      ];

      final results = <bool>[];
      cafes.forEach((c) => results.add(filter.apply(c)));

      expect(results, [true, false, false]);
    });

    test('Given onlyOpen=false, all cafes can apply', () {
      final filter = Filter(onlyOpen: false);
      final cafes = [
        Cafe(openNow: true, tags: []),
        Cafe(openNow: false, tags: []),
        Cafe(openNow: false, tags: [])
      ];

      final results = <bool>[];
      cafes.forEach((c) => results.add(filter.apply(c)));

      expect(results, [true, true, true]);
    });

    test(
        //ignore: lines_longer_than_80_chars
        'Given tags to filter and onlyOpen=true, only cafes with given tag should apply',
        () {
      //todo repair
      // final tags = [
      //   TagEntity(title: 'a'),
      //   TagEntity(title: 'b'),
      //   TagEntity(title: 'c')
      // ];
      // final filter = FilterEntity(tags: [tags[0], tags[1]]);
      // final cafes = [
      //   CafeEntity(openNow: true, tags: [tags[2], tags[0]]),
      //   CafeEntity(openNow: true, tags: [tags[2]]),
      //   CafeEntity(openNow: false, tags: tags)
      // ];

      // final List<bool> results = [];
      // cafes.forEach((c) => results.add(filter.apply(c)));

      // expect(results, [true, false, false]);
    });
  });
}
