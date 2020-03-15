import 'package:equatable/equatable.dart';

import '../../../../domain/entities/filter.dart';

class FilterBlocState extends Equatable {
  final Filter filter;

  FilterBlocState({
    this.filter,
  });

  @override
  List<Object> get props => [filter];

  @override
  bool get stringify => true;
}
