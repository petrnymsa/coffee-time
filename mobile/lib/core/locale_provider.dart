import 'package:intl/intl.dart';

class LocaleProvider {
  static String getLocale() => Intl.getCurrentLocale();
  static String getShortLocale() => Intl.shortLocale(getLocale());
  static String getLocaleWithDashFormat() => getLocale().replaceFirst('_', '-');
}
