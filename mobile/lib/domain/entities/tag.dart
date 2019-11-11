import 'package:flutter/material.dart';

//todo reputation score
class TagEntity {
  final String title;
  final IconData
      icon; // ! do not belong here - dependency on material (UI) layer - give isntead DEC int value
  final Color
      color; //! do not belong here - dependency on material (UI) layer - give isntead HEX value

  TagEntity({this.title, this.icon, this.color = Colors.blueGrey})
      : assert(title != null);
}
