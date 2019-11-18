import 'package:coffee_time/domain/entities/cafe.dart';

import './tag.dart';

class FilterEntity {
  final bool onlyOpen;
  final List<TagEntity> tags;

  FilterEntity({this.onlyOpen = true, this.tags});

  bool apply(CafeEntity entity) {
    if (onlyOpen && !entity.openNow) return false;

    if (tags != null && !entity.tags.any((t) => tags.contains(t))) return false;

    return true;
  }
}
