import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String avatar;
  final String user;
  final DateTime posted;
  final double rating;
  final String content;

  CommentEntity(
      {this.avatar, this.user, this.posted, this.rating, this.content});

  @override
  List<Object> get props => [avatar, user, posted, rating, content];

  CommentEntity copyWith({
    String id,
    String user,
    DateTime posted,
    double rating,
    String content,
  }) {
    return CommentEntity(
      avatar: id ?? this.avatar,
      user: user ?? this.user,
      posted: posted ?? this.posted,
      rating: rating ?? this.rating,
      content: content ?? this.content,
    );
  }
}
