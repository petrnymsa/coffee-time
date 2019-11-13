import 'package:coffee_time/domain/entities/photo.dart';
import 'package:meta/meta.dart';

class PhotoModel extends PhotoEntity {
  PhotoModel({@required String url, @required int width, @required int height})
      : super(url: url, width: width, height: height);

  factory PhotoModel.fromJson(Map<String, dynamic> json) {
    return PhotoModel(
        url: json['photo_reference'],
        width: json['width'],
        height: json['height']);
  }

  Map<String, dynamic> toJson() {
    return {'photo_reference': url, 'width': width, 'height': height};
  }
}
