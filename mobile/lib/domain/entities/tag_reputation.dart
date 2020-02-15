import 'package:equatable/equatable.dart';

import 'tag.dart';

class TagReputation extends Equatable {
  final String id;
  final int likes;
  final int dislikes;
  final Tag tag;

  int get score => likes - dislikes;

  TagReputation({
    this.id,
    this.tag,
    this.likes,
    this.dislikes,
  });

  TagReputation copyWith({String id, int likes, int dislikes, Tag tagEntity}) {
    return TagReputation(
        id: id ?? this.id,
        likes: likes ?? this.likes,
        dislikes: dislikes ?? this.dislikes,
        tag: tagEntity ?? this.tag);
  }

  @override
  String toString() =>
      'TagReputation id: $id, likes: $likes, dislikes: $dislikes, tag: $tag';

  @override
  List<Object> get props => [id, likes, dislikes, tag];
}
