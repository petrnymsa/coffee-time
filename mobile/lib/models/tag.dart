import 'package:flutter/material.dart';

//TODO reputation score
class Tag {
  final String title;
  final IconData
      icon; // ! do not belong here - dependency on material (UI) layer - give isntead DEC int value
  final Color
      color; //! do not belong here - dependency on material (UI) layer - give isntead HEX value

  Tag({this.title, this.icon, this.color = Colors.blueGrey})
      : assert(title != null);
}
