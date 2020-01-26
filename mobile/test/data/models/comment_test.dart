import 'dart:convert';

import 'package:coffee_time/data/models/comment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  group('fromJson', () {
    test('Given valid comment json, should return comment model', () async {
      await initializeDateFormatting('en');
      var jsonInput = r'''{ "author_name": "Cob Peasee",
                "rating": 4,
                "relative_time_description": "6/19/2019",
                "text": "disintermediate real-time infomediaries",
                "profile_photo_url": "https://robohash.org/eosetfuga.bmp?size=50x50&set=set1"}''';
      var model = CommentModel(
          user: "Cob Peasee",
          rating: 4,
          posted: DateTime(2019, 6, 19),
          content: "disintermediate real-time infomediaries",
          avatar: "https://robohash.org/eosetfuga.bmp?size=50x50&set=set1");

      var result = CommentModel.fromJson(json.decode(jsonInput));

      expect(result, model);
    });
  });
}
