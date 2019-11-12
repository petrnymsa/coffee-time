import 'package:equatable/equatable.dart';

class PhotoEntity extends Equatable {
  final String url;
  final int width;
  final int height;

  PhotoEntity({this.url, this.width, this.height});

  @override
  List<Object> get props => [url, width, height];

  PhotoEntity copyWith({
    String url,
    int width,
    int height,
  }) {
    return PhotoEntity(
      url: url ?? this.url,
      width: width ?? this.width,
      height: height ?? this.height,
    );
  }
}
