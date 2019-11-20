import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

//todo reputation score
class TagEntity extends Equatable {
  final String title;
  final IconData
      icon; // ! do not belong here - dependency on material (UI) layer - give isntead DEC int value

  TagEntity({this.title, this.icon});

  @override
  List<Object> get props => [title];

  @override
  String toString() {
    // todo: implement toString
    return 'Tag: $title';
  }
}
