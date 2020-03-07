import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

enum TagUpdateKind { like, dislike }

class TagUpdate extends Equatable {
  final String id;
  final TagUpdateKind change;
  TagUpdate({
    this.id,
    this.change,
  });

  TagUpdate copyWith({
    String id,
    TagUpdateKind change,
  }) {
    return TagUpdate(
      id: id ?? this.id,
      change: change ?? this.change,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'change': change.toString().split('.').last,
    };
  }

  static TagUpdate fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TagUpdate(
      id: map['id'],
      change: TagUpdateKind.values.firstWhere(
          (x) => x.toString().split('.').last == map['change'],
          orElse: () => null),
    );
  }

  String toJson() => json.encode(toMap());

  static TagUpdate fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'TagUpdate(id: $id, change: $change)';

  @override
  List<Object> get props => [id, change];
}
