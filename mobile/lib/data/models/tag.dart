import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class TagModel {
  final String id;
  final String title;
  final IconData icon;
  final Map<String, String> translations;

  TagModel({
    @required this.id,
    @required this.title,
    @required this.icon,
    @required this.translations,
  });

  TagModel copyWith({
    String id,
    String title,
    IconData icon,
    Map<String, String> translations,
  }) {
    return TagModel(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      translations: translations ?? this.translations,
    );
  }

  Map<String, dynamic> _iconToMap() {
    return {
      "code": this.icon.codePoint,
      "family": this.icon.fontFamily,
      "package": this.icon.fontPackage
    };
  }

  static IconData _iconFromMap(Map<String, dynamic> map) {
    return new IconData(map['code'],
        fontFamily: map['family'], fontPackage: map['package']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': _iconToMap(),
      'translations': translations,
    };
  }

  static TagModel fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return TagModel(
      id: map['id'],
      title: map['title'],
      icon: _iconFromMap(map['icon']),
      translations: Map<String, String>.from(map['translations']),
    );
  }

  String toJson() => json.encode(toMap());

  static TagModel fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'TagModel id: $id, title: $title, icon: $icon, translations: $translations';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TagModel &&
        o.id == id &&
        o.title == title &&
        o.icon == icon &&
        o.translations == translations;
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ icon.hashCode ^ translations.hashCode;
  }
}
