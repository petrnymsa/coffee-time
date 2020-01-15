import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/entities/comment.dart';
import 'package:coffee_time/domain/entities/contact.dart';
import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/photo.dart';
import 'package:coffee_time/domain/entities/tag.dart';

class CafeDetailEntity extends CafeEntity {
  final ContactEntity contact;
  final String cafeUrl;
  final List<CommentEntity> comments;

  CafeDetailEntity(
      {String id,
      String name,
      String address,
      double rating,
      bool openNow,
      bool isFavorite = false,
      LocationEntity location,
      List<PhotoEntity> photos,
      List<TagEntity> tags,
      this.contact,
      this.cafeUrl,
      this.comments})
      : super(
            id: id,
            name: name,
            address: address,
            rating: rating,
            openNow: openNow,
            isFavorite: isFavorite,
            location: location,
            photos: photos,
            tags: tags);

  CafeDetailEntity copyWith(
      {String id,
      String name,
      String address,
      double rating,
      bool openNow,
      LocationEntity location,
      List<PhotoEntity> photos,
      List<TagEntity> tags,
      bool isFavorite,
      ContactEntity contact,
      String cafeUrl,
      List<CommentEntity> comments}) {
    return CafeDetailEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        address: address ?? this.address,
        rating: rating ?? this.rating,
        openNow: openNow ?? this.openNow,
        location: location ?? this.location,
        photos: photos ?? this.photos,
        tags: tags ?? this.tags,
        isFavorite: isFavorite ?? this.isFavorite,
        contact: contact ?? this.contact,
        cafeUrl: cafeUrl ?? this.cafeUrl,
        comments: comments ?? this.comments);
  }

  factory CafeDetailEntity.fromCafe(CafeEntity entity,
      {ContactEntity contact,
      String cafeUrl,
      List<CommentEntity> comments,
      List<PhotoEntity> additionalPhotos}) {
    return CafeDetailEntity(
      id: entity.id,
      name: entity.name,
      address: entity.address,
      rating: entity.rating,
      openNow: entity.openNow,
      isFavorite: entity.isFavorite,
      location: entity.location,
      photos: [...entity.photos, ...additionalPhotos],
      tags: entity.tags,
      contact: contact,
      cafeUrl: cafeUrl,
      comments: comments,
    );
  }

  @override
  List<Object> get props => [...super.props, contact, cafeUrl, comments];
}
