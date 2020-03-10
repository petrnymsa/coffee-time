import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Photo extends Equatable {
  final int maxWidth;
  final int maxHeight;
  final String baseUrl;

  Photo({
    @required this.maxWidth,
    @required this.maxHeight,
    @required this.baseUrl,
  });

  Photo copyWith({
    int maxWidth,
    int maxHeight,
    String baseUrl,
  }) {
    return Photo(
      maxWidth: maxWidth ?? this.maxWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      baseUrl: baseUrl ?? this.baseUrl,
    );
  }

  @override
  String toString() =>
      '''PhotoEntity width: $maxWidth, height: $maxHeight, url: $baseUrl''';

  @override
  List<Object> get props => [baseUrl, maxWidth, maxHeight];
}
