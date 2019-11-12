import 'package:flutter/material.dart';

//todo reputation score
class TagEntity {
  final String title;
  final IconData
      icon; // ! do not belong here - dependency on material (UI) layer - give isntead DEC int value

  TagEntity({this.title, this.icon}) : assert(title != null);
}
