import 'package:coffee_time/domain/entities/cafe.dart';

import './tag.dart';

class FilterEntity {
  final bool onlyOpen;
  final List<TagEntity> tags;

  const FilterEntity({this.onlyOpen = true, this.tags = const []});

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
  }) {
    return FilterEntity(
      onlyOpen: onlyOpen ?? this.onlyOpen,
      tags: tags ?? this.tags,
    );
  }

  bool isDefault() {
    return onlyOpen == true && tags.length == 0;
  }

  @override
  String toString() => 'onlyOpen: $onlyOpen, tags: $tags';
}
