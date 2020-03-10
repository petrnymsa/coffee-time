import 'package:equatable/equatable.dart';

import '../../domain/entities/tag_update.dart';

class TagUpdateModel extends Equatable {
  final String id;
  final TagUpdateKind change;
  TagUpdateModel({
    this.id,
    this.change,
  });

  TagUpdateModel copyWith({
    String id,
    TagUpdateKind change,
  }) {
    return TagUpdateModel(
      id: id ?? this.id,
      change: change ?? this.change,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'change': change.toString().split('.').last,
    };
  }

  static TagUpdateModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return TagUpdateModel(
      id: map['id'],
      change: TagUpdateKind.values.firstWhere(
          (x) => x.toString().split('.').last == map['change'],
          orElse: () => null),
    );
  }

  @override
  String toString() => 'TagUpdate(id: $id, change: $change)';

  @override
  List<Object> get props => [id, change];

  TagUpdate toEnity() => TagUpdate(id: id, change: change);
}
