import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/comment.dart';
import 'package:coffee_time/domain/entities/contact.dart';
import 'package:coffee_time/domain/entities/photo.dart';

class CafeDetailEntity extends CafeEntity {
  final String cafeId;
  final ContactEntity contact;

  final String cafeUrl;

  final List<CommentEntity> comments;

  CafeDetailEntity.fromCafe(CafeEntity entity,
      {this.contact,
      this.cafeUrl,
      this.comments,
      List<PhotoEntity> additionalPhotos})
      : cafeId = entity.id,
        super(
            id: entity.id, //todo random uuuid?
            name: entity.name,
            address: entity.address,
            rating: entity.rating,
            openNow: entity.openNow,
            isFavorite: entity.isFavorite,
            location: entity.location,
            photos: [...entity.photos, ...additionalPhotos],
            tags: entity.tags);
}
