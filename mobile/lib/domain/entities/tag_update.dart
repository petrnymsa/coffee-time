import 'package:equatable/equatable.dart';

enum TagUpdateKind { like, dislike }

class TagUpdate extends Equatable {
  final String id;
  final TagUpdateKind change;

  TagUpdate({
    this.id,
    this.change,
  });

  @override
  List<Object> get props => null;

  TagUpdate copyWith({
    String id,
    TagUpdateKind change,
  }) {
    return TagUpdate(
      id: id ?? this.id,
      change: change ?? this.change,
    );
  }

  @override
  String toString() => 'TagUpdate(id: $id, change: $change)';
}
