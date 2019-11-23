import 'package:coffee_time/domain/entities/cafe.dart';

import './tag.dart';

enum FilterOrdering { distance, rating }

class FilterEntity {
  final bool onlyOpen;
  final List<TagEntity> tags;
  final FilterOrdering ordering;

  const FilterEntity(
      {this.onlyOpen = true,
      this.tags = const [],
      this.ordering = FilterOrdering.distance});

  static const FilterEntity defaultFilter = const FilterEntity();

  bool apply(CafeEntity entity) {
    if (onlyOpen && !entity.openNow) return false;

    if (tags != null &&
        tags.length > 0 &&
        !entity.tags.any((t) => tags.contains(t))) return false;

    return true;
  }

  FilterEntity copyWith({
    bool onlyOpen,
    List<TagEntity> tags,
    FilterOrdering ordering,
  }) {
    return FilterEntity(
        onlyOpen: onlyOpen ?? this.onlyOpen,
        tags: tags ?? this.tags,
        ordering: ordering ?? this.ordering);
  }

  bool isDefault() {
    return onlyOpen == true &&
        tags.length == 0 &&
        ordering == FilterOrdering.distance;
  }

  @override
  String toString() => 'onlyOpen: $onlyOpen, tags: $tags, ordering: $ordering';
}
