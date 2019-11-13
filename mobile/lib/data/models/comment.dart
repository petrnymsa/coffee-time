import 'package:coffee_time/domain/entities/comment.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

class CommentModel extends CommentEntity {
  CommentModel(
      {@required String avatar,
      @required String user,
      @required DateTime posted,
      @required double rating,
      @required String content})
      : super(
            avatar: avatar,
            user: user,
            posted: posted,
            rating: rating,
            content: content);

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      avatar: json['profile_photo_url'],
      user: json['author_name'],
      rating: json['rating'].toDouble(),
      posted: DateFormat.yMd().parse(json['relative_time_description']),
      content: json['text'],
    );
  }

  Map<String, dynamic> toJson() {
    return null;
  }
}
