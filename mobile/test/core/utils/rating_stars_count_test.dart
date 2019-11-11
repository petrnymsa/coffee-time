import 'package:coffee_time/core/utils/rating_stars_count.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RatingStarsCount.fromRating', () {
    test("Given rating 5 from 5, full should be 5 and other zero", () {
      final rating = RatingStarsCount.fromRating(5);
      expect(rating.full, 5);
      expect(rating.half, 0);
      expect(rating.empty, 0);
    });

    test("Given rating 0 from 5, empty should be 5 and other zero", () {
      final rating = RatingStarsCount.fromRating(0);
      expect(rating.full, 0);
      expect(rating.half, 0);
      expect(rating.empty, 5);
    });

    test("Given rating 3 from 5, full should be 3, half zero and empty 2", () {
      final rating = RatingStarsCount.fromRating(3);
      expect(rating.full, 3);
      expect(rating.half, 0);
      expect(rating.empty, 2);
    });

    test("Given rating 3.3 from 5, full should be 3, half 1 and empty 1", () {
      final rating = RatingStarsCount.fromRating(3.3);
      expect(rating.full, 3);
      expect(rating.half, 1);
      expect(rating.empty, 1);
    });

    test("Given rating 4.8 from 5, full should be 5, half 0 and empty 0", () {
      final rating = RatingStarsCount.fromRating(4.8);
      expect(rating.full, 5);
      expect(rating.half, 0);
      expect(rating.empty, 0);
    });

    test("Given rating 4.5 from 5, full should be 4, half 1 and empty 0", () {
      final rating = RatingStarsCount.fromRating(4.5);
      expect(rating.full, 4);
      expect(rating.half, 1);
      expect(rating.empty, 0);
    });
    test("Given rating 0.2 from 5, full should be 0, half 1 and empty 4", () {
      final rating = RatingStarsCount.fromRating(0.2);
      expect(rating.full, 0);
      expect(rating.half, 1);
      expect(rating.empty, 4);
    });
  });
}
