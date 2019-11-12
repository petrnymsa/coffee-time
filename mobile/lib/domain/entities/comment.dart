import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String user;
  final DateTime posted;
  final double rating;
  final String content;

  CommentEntity({this.id, this.user, this.posted, this.rating, this.content});

  @override
  List<Object> get props => [id, user, posted, rating, content];

  CommentEntity copyWith({
    String id,
    String user,
    DateTime posted,
    double rating,
    String content,
  }) {
    return CommentEntity(
      id: id ?? this.id,
      user: user ?? this.user,
      posted: posted ?? this.posted,
      rating: rating ?? this.rating,
      content: content ?? this.content,
    );
  }
}
