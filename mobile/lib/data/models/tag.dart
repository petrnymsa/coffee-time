import 'package:coffee_time/domain/entities/tag.dart';
import 'package:flutter/material.dart';

class TagModel extends TagEntity {
  TagModel(
      {@required String title,
      @required IconData icon}) //!big NONO with IconData, but for now...
      : super(title: title, icon: icon);

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return null; //todo implement
  }

  Map<String, dynamic> toJson() {
    return null; //todo implement
  }
}
