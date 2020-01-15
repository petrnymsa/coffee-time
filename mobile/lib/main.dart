import 'package:coffee_time/presentation/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:logger/logger.dart';

void main() async {
  await initializeDateFormatting('cs');
  await initializeDateFormatting('en');

  Intl.defaultLocale = await findSystemLocale();

  // Logger setup
  if (kDebugMode)
    Logger.level = Level.debug;
  else
    Logger.level = Level.nothing;

  runApp(App());
}
