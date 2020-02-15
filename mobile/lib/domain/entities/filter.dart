import 'cafe.dart';
import 'tag.dart';

enum FilterOrdering { distance, rating }

class Filter {
  final bool onlyOpen;
  final List<Tag> tags;
  final FilterOrdering ordering;

  const Filter(
      {this.onlyOpen = true,
      this.tags = const [],
      this.ordering = FilterOrdering.distance});

  static const Filter defaultFilter = const Filter();

  bool apply(Cafe entity) {
    if (onlyOpen && !entity.openNow) return false;

    if (tags != null &&
        tags.length > 0 &&
        !entity.tags.any((t) => tags.contains(t))) return false;

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
}
