import 'package:equatable/equatable.dart';

import '../../domain/entities/tag.dart';
import '../../domain/entities/tag_reputation.dart';

class TagReputationModel extends Equatable {
  final String id;
  final int likes;
  final int dislikes;

  int get score => likes - dislikes;

  static const int minimalScore = -1;

  TagReputationModel({
    this.id,
    this.likes,
    this.dislikes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'likes': likes,
      'dislikes': dislikes,
    };
  }

  static TagReputationModel fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    return TagReputationModel(
      id: map['id'],
      likes: map['likes'] ?? 0,
      dislikes: map['dislikes'] ?? 0,
    );
  }

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
