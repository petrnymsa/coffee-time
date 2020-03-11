import 'package:equatable/equatable.dart';

import 'cafe.dart';
import 'tag.dart';

enum FilterOrdering { distance, popularity }

class Filter extends Equatable {
  final bool onlyOpen;
  final List<Tag> tags;
  final FilterOrdering ordering;
  final int radius; //todo  ???

  const Filter({
    this.onlyOpen = true,
    this.tags = const [],
    this.ordering = FilterOrdering.distance,
    this.radius = 2500,
  });

  static const Filter defaultFilter = Filter();

  bool apply(Cafe entity) {
    if (onlyOpen && !entity.openNow) return false;

    if (tags != null && tags.length > 0 && !entity.tags.any(tags.contains)) {
      return false;
    }

    return true;
  }

  Filter copyWith({
    bool onlyOpen,
    List<Tag> tags,
    FilterOrdering ordering,
  }) {
    return Filter(
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

  @override
  List<Object> get props => [onlyOpen, tags, ordering, radius];

  @override
  bool get stringify => true;
}
