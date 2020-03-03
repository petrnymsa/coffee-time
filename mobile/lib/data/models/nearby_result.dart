import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'cafe.dart';

class NearbyResultModel extends Equatable {
  final List<CafeModel> cafes;
  final String nextPageToken;

  NearbyResultModel({@required this.cafes, this.nextPageToken});

  @override
  List<Object> get props => [cafes, nextPageToken];
}
