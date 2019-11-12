import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/domain/entities/photo.dart';
import 'package:coffee_time/domain/entities/tag.dart';

class CafeEntity {
  final String id;
  final String name;
  final String address;
  final double rating;
  final bool openNow;
  final LocationEntity location;

  final List<PhotoEntity> photos;
  final List<TagEntity> tags;

  bool isFavorite;

  CafeEntity(
      {this.id,
      this.name,
      this.address,
      this.rating,
      this.openNow,
      this.isFavorite = false,
      this.location,
      this.photos,
      this.tags})
      : assert(id != null),
        assert(name != null),
        assert(address != null);
}
