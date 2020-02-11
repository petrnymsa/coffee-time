import 'package:coffee_time/core/utils/query_string_builder.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QueryParametersBuilder', () {
    test('Given no values, empty string is returned', () {
      final builder = QueryStringBuilder();

      final result = builder.build();
      expect(result, '');
    });

    test('After build, builder is cleared', () {
      final builder = QueryStringBuilder();
      builder.add('key', 'value');

      expect(builder.isNotEmpty, true);
      builder.build();
      expect(builder.isNotEmpty, false);
    });

    test('Given number value, query string is returned', () {
      final builder = QueryStringBuilder();
      builder.add('number', 123);

      final result = builder.build();
      expect(result, 'number=123');
    });

    test('Given string value, query string is returned and properly encoded',
        () {
      final builder = QueryStringBuilder();
      builder.add('str', 'foo bar');

      final result = builder.build();
      expect(result, 'str=foo%20bar');
    });

    test('When clear is set to false, builder is not cleared after build', () {
      final builder = QueryStringBuilder();
      builder.add('number', 123);

      final result = builder.build(clear: false);
      expect(result, 'number=123');
      expect(builder.isNotEmpty, true);
      expect(builder.build(), 'number=123');
    });
  });
}
