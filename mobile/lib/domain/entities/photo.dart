import 'package:equatable/equatable.dart';

class PhotoEntity extends Equatable {
  final int width;
  final int height;
  final String url; //todo map from service to REST API url

  PhotoEntity({
    this.width,
    this.height,
    this.url,
  });

  PhotoEntity copyWith({
    int width,
    int height,
    String reference,
  }) {
    return PhotoEntity(
      width: width ?? this.width,
      height: height ?? this.height,
      url: reference ?? this.url,
    );
  }

  @override
  String toString() =>
      'PhotoEntity width: $width, height: $height, reference: $url';

  @override
  List<Object> get props => [url, width, height];
}
