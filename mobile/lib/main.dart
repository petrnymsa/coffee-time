import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:logger/logger.dart';

import 'di_container.dart';
import 'presentation/app.dart';

Future setupLocalization() async {
  await initializeDateFormatting('cs');
  await initializeDateFormatting('en');

  Intl.defaultLocale = await findSystemLocale();
}

void main() async {
  await setupLocalization();

  setupContainer();

  // Logger setup
  if (kDebugMode) {
    Logger.level = Level.debug;
  } else {
    Logger.level = Level.nothing;
  }

  runApp(App());
}
