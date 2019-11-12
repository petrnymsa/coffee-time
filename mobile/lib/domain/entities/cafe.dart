import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/photo.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:equatable/equatable.dart';

class CafeEntity extends Equatable {
  final String id;
  final String name;
  final String address;
  final double rating;
  final bool openNow;
  final LocationEntity location;

  final List<PhotoEntity> photos;
  final List<TagEntity> tags;

  final bool isFavorite;

  CafeEntity(
      {this.id,
      this.name,
      this.address,
      this.rating,
      this.openNow,
      this.isFavorite = false,
      this.location,
      this.photos,
      this.tags});

  @override
  List<Object> get props =>
      [id, name, address, rating, openNow, isFavorite, location, photos, tags];

  CafeEntity copyWith({
    String id,
    String name,
    String address,
    double rating,
    bool openNow,
    LocationEntity location,
    List<PhotoEntity> photos,
    List<TagEntity> tags,
    bool isFavorite,
  }) {
    return CafeEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      rating: rating ?? this.rating,
      openNow: openNow ?? this.openNow,
      location: location ?? this.location,
      photos: photos ?? this.photos,
      tags: tags ?? this.tags,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
