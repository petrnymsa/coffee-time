import 'package:coffee_time/models/tag.dart';

class Cafe {
  final String id;
  final String title;
  final String address;
  final double distance;
  final double rating;

  final String mainPhotoUrl;
  final DateTime closing;
  final bool isFavorite;

  final List<Tag> tags;

  Cafe(
      {this.id,
      this.title,
      this.address,
      this.distance,
      this.rating,
      this.mainPhotoUrl,
      this.closing,
      this.isFavorite = false,
      this.tags})
      : assert(id != null),
        assert(title != null),
        assert(address != null);
}
