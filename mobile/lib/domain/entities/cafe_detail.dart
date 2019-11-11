import 'package:coffee_time/domain/entities/comment.dart';
import 'package:coffee_time/domain/entities/contact.dart';
import 'package:coffee_time/domain/entities/photo.dart';

class CafeDetailEntity {
  final String id;
  final String cafeId;
  final ContactEntity contact;

  final String cafeUrl;

  final List<CommentEntity> comments;
  final List<PhotoEntity> photos;

  CafeDetailEntity(
      {this.id,
      this.cafeId,
      this.contact,
      this.cafeUrl,
      this.comments,
      this.photos});
}
