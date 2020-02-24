import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../entities/cafe.dart';

class NearbyResult extends Equatable {
  final List<Cafe> cafes;
  final String nextPageToken;

  NearbyResult({@required this.cafes, this.nextPageToken});

  @override
  List<Object> get props => [cafes, nextPageToken];
}
