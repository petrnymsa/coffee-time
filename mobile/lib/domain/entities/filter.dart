import 'package:equatable/equatable.dart';

enum FilterOrdering { distance, popularity }

class Filter extends Equatable {
  final bool onlyOpen;
  final List<String> tagIds;
  final FilterOrdering ordering;
  final int radius;

  const Filter({
    this.onlyOpen = true,
    this.tagIds = const [],
    this.ordering = FilterOrdering.distance,
    this.radius = 2500,
  });

  static const Filter defaultFilter = Filter();

  bool filterTags(List<String> ids) {
    return tagIds.isEmpty || ids.any(tagIds.contains);
  }

  Filter copyWith({
    bool onlyOpen,
    List<String> tagIds,
    FilterOrdering ordering,
  }) {
    return Filter(
        onlyOpen: onlyOpen ?? this.onlyOpen,
        tagIds: tagIds ?? this.tagIds,
        ordering: ordering ?? this.ordering);
  }

  bool isDefault() => this == Filter();

  @override
  String toString() =>
      'onlyOpen: $onlyOpen, tags: $tagIds, ordering: $ordering';

  @override
  List<Object> get props => [onlyOpen, tagIds, ordering, radius];

  @override
  bool get stringify => true;
}
