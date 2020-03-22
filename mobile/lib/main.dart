import 'package:coffee_time/core/app_logger.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:logger/logger.dart';

import 'di_container.dart';
import 'presentation/app.dart';

Future setupLocalization() async {
  // await initializeDateFormatting('cs');
  // await initializeDateFormatting('en');

  Intl.defaultLocale = await findSystemLocale();
}

Logger blocLogger;

void main() async {
  await setupLocalization();

  setupContainer();

  // Logger setup
  if (kDebugMode) {
    Logger.level = Level.debug;
  } else {
    Logger.level = Level.nothing;
  }

  //Setup Bloc logger
  if (kDebugMode) {
    BlocSupervisor.delegate = SimpleBlocDelegate();
    blocLogger = getLogger('Bloc');
  }

  runApp(App());
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    blocLogger.i(transition);
  }
}
