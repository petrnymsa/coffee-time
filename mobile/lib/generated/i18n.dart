import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: camel_case_types
// ignore_for_file: prefer_single_quotes
// ignore_for_file: unnecessary_brace_in_string_interps

//WARNING: This file is automatically generated. DO NOT EDIT, all your changes would be lost.

typedef LocaleChangeCallback = void Function(Locale locale);

class I18n implements WidgetsLocalizations {
  const I18n();
  static Locale _locale;
  static bool _shouldReload = false;

  static set locale(Locale newLocale) {
    _shouldReload = true;
    I18n._locale = newLocale;
  }

  static const GeneratedLocalizationsDelegate delegate = GeneratedLocalizationsDelegate();

  /// function to be invoked when changing the language
  static LocaleChangeCallback onLocaleChanged;

  static I18n of(BuildContext context) =>
    Localizations.of<I18n>(context, WidgetsLocalizations);

  @override
  TextDirection get textDirection => TextDirection.ltr;

  /// "Refresh"
  String get refresh => "Refresh";
  /// "Confirm"
  String get confirm => "Confirm";
  /// "Oops, something went wrong."
  String get somethingWrong => "Oops, something went wrong.";
  /// "Cafes"
  String get tabs_cafes => "Cafes";
  /// "Favorites"
  String get tabs_favorites => "Favorites";
  /// "Map"
  String get tabs_map => "Map";
  /// "Settings"
  String get tabs_settings => "Settings";
  /// "Open"
  String get openingHours_open => "Open";
  /// "Closed"
  String get openingHours_closed => "Closed";
  /// "No cafes found."
  String get cafeList_noCafes => "No cafes found.";
  /// "No favorites yet."
  String get favorites_noFavorites => "No favorites yet.";
  /// "Navigate"
  String get detail_navigate => "Navigate";
  /// "Opening hours"
  String get detail_openingHoursTitle => "Opening hours";
  /// "Tags"
  String get detail_tagsTitle => "Tags";
  /// "No tags added"
  String get detail_noTags => "No tags added";
  /// "Suggest change"
  String get detail_suggestChange => "Suggest change";
  /// "Reviews"
  String get detail_reviewsTitle => "Reviews";
  /// "Web page"
  String get detail_webpage => "Web page";
  /// "Suggest changes"
  String get reviews_title => "Suggest changes";
  /// "Add tags"
  String get reviews_add => "Add tags";
  /// "Users create tags. Could you help us improve them?"
  String get reviews_headerTitle => "Users create tags. Could you help us improve them?";
  /// "It's not necessary to review each tag."
  String get reviews_haederSubTitle => "It's not necessary to review each tag.";
  /// "True"
  String get reviews_true => "True";
  /// "False"
  String get reviews_false => "False";
  /// "Chosen tags"
  String get reviews_chosenTags => "Chosen tags";
  /// "Clear tags"
  String get reviews_clearTags => "Clear tags";
  /// "Choose tags"
  String get addTags_title => "Choose tags";
  /// "Choose one or more tags."
  String get addTags_header => "Choose one or more tags.";
  /// "Edit filter"
  String get filter_title => "Edit filter";
  /// "Opening hours"
  String get filter_openingHours_title => "Opening hours";
  /// "Show only open cafes"
  String get filter_openingHours_onlyOpen => "Show only open cafes";
  /// "Sort"
  String get filter_orderBy_title => "Sort";
  /// "Sort by popularity"
  String get filter_orderBy_popularity => "Sort by popularity";
  /// "Sort by distance"
  String get filter_orderBy_distance => "Sort by distance";
  /// "Tags"
  String get filter_tags_title => "Tags";
  /// "Cafe should contain at least one selected tag."
  String get filter_tags_info => "Cafe should contain at least one selected tag.";
  /// "Choose tags"
  String get filter_tags_chooseTags => "Choose tags";
  /// "Chosen tags"
  String get filter_tags_chosenTags => "Chosen tags";
  /// "Clear tags"
  String get filter_tags_clear => "Clear tags";
  /// "Added to favorites"
  String get notification_favoriteAdded => "Added to favorites";
  /// "Removed from favorites"
  String get notification_favoriteRemoved => "Removed from favorites";
}

class _I18n_en_US extends I18n {
  const _I18n_en_US();

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class _I18n_cs_CZ extends I18n {
  const _I18n_cs_CZ();

  /// "Obnovit"
  @override
  String get refresh => "Obnovit";
  /// "Potvrdit"
  @override
  String get confirm => "Potvrdit";
  /// "Jejda! Něco se pokazilo."
  @override
  String get somethingWrong => "Jejda! Něco se pokazilo.";
  /// "Kavárny"
  @override
  String get tabs_cafes => "Kavárny";
  /// "Oblíbené"
  @override
  String get tabs_favorites => "Oblíbené";
  /// "Mapa"
  @override
  String get tabs_map => "Mapa";
  /// "Nastavení"
  @override
  String get tabs_settings => "Nastavení";
  /// "Otevřeno"
  @override
  String get openingHours_open => "Otevřeno";
  /// "Zavřeno"
  @override
  String get openingHours_closed => "Zavřeno";
  /// "Nebyly nalezeny žádné kavárny."
  @override
  String get cafeList_noCafes => "Nebyly nalezeny žádné kavárny.";
  /// "Zatím žádné oblíbené."
  @override
  String get favorites_noFavorites => "Zatím žádné oblíbené.";
  /// "Navigovat"
  @override
  String get detail_navigate => "Navigovat";
  /// "Otevírací doba"
  @override
  String get detail_openingHoursTitle => "Otevírací doba";
  /// "Štítky"
  @override
  String get detail_tagsTitle => "Štítky";
  /// "Nebyly přidány žádné štítky"
  @override
  String get detail_noTags => "Nebyly přidány žádné štítky";
  /// "Navrhnout změnu"
  @override
  String get detail_suggestChange => "Navrhnout změnu";
  /// "Recenze"
  @override
  String get detail_reviewsTitle => "Recenze";
  /// "Webová stránka"
  @override
  String get detail_webpage => "Webová stránka";
  /// "Navrhněte změny"
  @override
  String get reviews_title => "Navrhněte změny";
  /// "Přidat štítky"
  @override
  String get reviews_add => "Přidat štítky";
  /// "Uživatelé vytvářejí štítky. Můžete nám pomoci vylepšit je?"
  @override
  String get reviews_headerTitle => "Uživatelé vytvářejí štítky. Můžete nám pomoci vylepšit je?";
  /// "Není nutné hodnotit každý štítek."
  @override
  String get reviews_haederSubTitle => "Není nutné hodnotit každý štítek.";
  /// "Pravda"
  @override
  String get reviews_true => "Pravda";
  /// "Nepravdivé"
  @override
  String get reviews_false => "Nepravdivé";
  /// "Vybrané štítky"
  @override
  String get reviews_chosenTags => "Vybrané štítky";
  /// "Vymazat štítky"
  @override
  String get reviews_clearTags => "Vymazat štítky";
  /// "Vyberte štítky"
  @override
  String get addTags_title => "Vyberte štítky";
  /// "Vyberte jeden nebo více štítků."
  @override
  String get addTags_header => "Vyberte jeden nebo více štítků.";
  /// "Upravit filtr"
  @override
  String get filter_title => "Upravit filtr";
  /// "Otevírací doba"
  @override
  String get filter_openingHours_title => "Otevírací doba";
  /// "Pouze otevřené kavárny"
  @override
  String get filter_openingHours_onlyOpen => "Pouze otevřené kavárny";
  /// "Řazení"
  @override
  String get filter_orderBy_title => "Řazení";
  /// "Seřadit podle oblíbenosti"
  @override
  String get filter_orderBy_popularity => "Seřadit podle oblíbenosti";
  /// "Seřadit podle vzdálenosti"
  @override
  String get filter_orderBy_distance => "Seřadit podle vzdálenosti";
  /// "Značky"
  @override
  String get filter_tags_title => "Značky";
  /// "Kavárna by měla obsahovat alespoň jeden vybraný štítek."
  @override
  String get filter_tags_info => "Kavárna by měla obsahovat alespoň jeden vybraný štítek.";
  /// "Vyberte štítky"
  @override
  String get filter_tags_chooseTags => "Vyberte štítky";
  /// "Vybrané štítky"
  @override
  String get filter_tags_chosenTags => "Vybrané štítky";
  /// "Vymazat štítky"
  @override
  String get filter_tags_clear => "Vymazat štítky";
  /// "Přidáno k oblíbeným"
  @override
  String get notification_favoriteAdded => "Přidáno k oblíbeným";
  /// "Odebráno z oblíbených"
  @override
  String get notification_favoriteRemoved => "Odebráno z oblíbených";

  @override
  TextDirection get textDirection => TextDirection.ltr;
}

class GeneratedLocalizationsDelegate extends LocalizationsDelegate<WidgetsLocalizations> {
  const GeneratedLocalizationsDelegate();
  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale("en", "US"),
      Locale("cs", "CZ")
    ];
  }

  LocaleResolutionCallback resolution({Locale fallback}) {
    return (Locale locale, Iterable<Locale> supported) {
      if (isSupported(locale)) {
        return locale;
      }
      final Locale fallbackLocale = fallback ?? supported.first;
      return fallbackLocale;
    };
  }

  @override
  Future<WidgetsLocalizations> load(Locale locale) {
    I18n._locale ??= locale;
    I18n._shouldReload = false;
    final String lang = I18n._locale != null ? I18n._locale.toString() : "";
    final String languageCode = I18n._locale != null ? I18n._locale.languageCode : "";
    if ("en_US" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }
    else if ("cs_CZ" == lang) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_cs_CZ());
    }
    else if ("en" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_en_US());
    }
    else if ("cs" == languageCode) {
      return SynchronousFuture<WidgetsLocalizations>(const _I18n_cs_CZ());
    }

    return SynchronousFuture<WidgetsLocalizations>(const I18n());
  }

  @override
  bool isSupported(Locale locale) {
    for (var i = 0; i < supportedLocales.length && locale != null; i++) {
      final l = supportedLocales[i];
      if (l.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }

  @override
  bool shouldReload(GeneratedLocalizationsDelegate old) => I18n._shouldReload;
}