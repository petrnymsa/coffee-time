import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../domain/entities/tag.dart';

enum TagReviewKind { like, dislike, none }

class TagReview extends Equatable {
  final Tag tag;
  final TagReviewKind review;

  TagReview({
    @required this.tag,
    @required this.review,
  });

  @override
  List<Object> get props => [tag, review];
}
