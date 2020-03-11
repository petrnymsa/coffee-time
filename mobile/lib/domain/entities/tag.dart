import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Tag extends Equatable {
  final String id;
  final String title;
  final IconData icon;
  final Map<String, String> translations;

  String get translatedTitle => _getTranslatedTitle();

  Tag({
    @required this.id,
    @required this.title,
    @required this.icon,
    this.translations = const {},
  });

  Tag copyWith({
    String id,
    String title,
    IconData icon,
    Map<String, String> translations,
  }) {
    return Tag(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      translations: translations ?? this.translations,
    );
  }

  String _getTranslatedTitle() {
    final locale = Intl.shortLocale(Intl.getCurrentLocale());

    if (translations.containsKey(locale)) {
      return translations[locale];
    }

    return title;
  }

  @override
  String toString() {
    return '''TagEntity id: $id, title: $title, icon: $icon, translations: $translations''';
  }

  @override
  List<Object> get props => [id, title, icon, translations];
}
