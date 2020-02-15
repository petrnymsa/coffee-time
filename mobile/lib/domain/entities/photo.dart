import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Photo extends Equatable {
  final int width;
  final int height;
  final String url; //todo map from service to REST API url

  Photo({
    @required this.width,
    @required this.height,
    @required this.url,
  });

  Photo copyWith({
    int width,
    int height,
    String url,
  }) {
    return Photo(
      width: width ?? this.width,
      height: height ?? this.height,
      url: url ?? this.url,
    );
  }

  @override
  String toString() => 'PhotoEntity width: $width, height: $height, url: $url';

  @override
  List<Object> get props => [url, width, height];
}
