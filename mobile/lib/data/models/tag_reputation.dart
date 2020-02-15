import 'dart:convert';

import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/domain/entities/tag_reputation.dart';
import 'package:equatable/equatable.dart';

class TagReputationModel extends Equatable {
  final String id;
  final int likes;
  final int dislikes;

  TagReputationModel({
    this.id,
    this.likes,
    this.dislikes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'likes': likes,
      'dislikes': dislikes,
    };
  }

  static TagReputationModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TagReputationModel(
      id: map['id'],
      likes: map['likes'],
      dislikes: map['dislikes'],
    );
  }

  String toJson() => json.encode(toMap());

  static TagReputationModel fromJson(String source) =>
      fromMap(json.decode(source));

  TagReputationModel copyWith({
    String id,
    int likes,
    int dislikes,
  }) {
    return TagReputationModel(
      id: id ?? this.id,
      likes: likes ?? this.likes,
      dislikes: dislikes ?? this.dislikes,
    );
  }

  @override
  String toString() =>
      'TagReputationModel id: $id, likes: $likes, dislikes: $dislikes';

  @override
  List<Object> get props => [id, likes, dislikes];

  TagReputation toEntity(Tag tag) =>
      TagReputation(id: id, likes: likes, dislikes: dislikes, tag: tag);
}
