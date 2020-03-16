import 'package:equatable/equatable.dart';

import '../../../../domain/entities/filter.dart';
import '../../../../domain/entities/tag.dart';

class FilterBlocState extends Equatable {
  final Filter filter;
  final List<Tag> addedTags;
  final List<Tag> notAddedTags;

  FilterBlocState(
      {this.filter, this.addedTags = const [], this.notAddedTags = const []});

  @override
  List<Object> get props => [filter, addedTags, notAddedTags];

  @override
  bool get stringify => true;

  FilterBlocState copyWith({
    Filter filter,
    List<Tag> addedTags,
    List<Tag> notAddedTags,
  }) {
    return FilterBlocState(
      filter: filter ?? this.filter,
      addedTags: addedTags ?? this.addedTags,
      notAddedTags: notAddedTags ?? this.notAddedTags,
    );
  }
}
