import 'package:equatable/equatable.dart';

import '../../../../domain/entities/filter.dart';
import '../../../../domain/entities/tag.dart';

class FilterBlocState extends Equatable {
  final Filter filter;
  final List<Tag> addedTags;
  final List<Tag> notAddedTags;
  final bool confirmed;

  FilterBlocState({
    this.filter,
    this.addedTags = const [],
    this.notAddedTags = const [],
    this.confirmed = false,
  });

  @override
  List<Object> get props => [filter, addedTags, notAddedTags, confirmed];

  @override
  bool get stringify => true;

  FilterBlocState copyWith({
    Filter filter,
    List<Tag> addedTags,
    List<Tag> notAddedTags,
    bool confirmed,
  }) {
    return FilterBlocState(
        filter: filter ?? this.filter,
        addedTags: addedTags ?? this.addedTags,
        notAddedTags: notAddedTags ?? this.notAddedTags,
        confirmed: confirmed ?? this.confirmed);
  }
}
