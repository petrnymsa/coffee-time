import 'package:coffee_time/data/models/photo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromJson', () {
    test('Given valid photo json, should return photo model', () {
      const reference = 'abc12';
      const width = 100;
      const height = 60;
      const json =
          '{"photo_reference": "$reference", "width": $width, "height": $height}';
      var model =
          PhotoModel(reference: reference, width: width, height: height);

      var result = PhotoModel.fromJson(json);

      expect(result, model);
    });
  });
}
