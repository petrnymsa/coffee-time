import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:logger/logger.dart';

import 'core/app_config.dart';
import 'core/app_logger.dart';
import 'di_container.dart';
import 'presentation/app.dart';

Future setupLocalization() async {
  // await initializeDateFormatting('cs');
  // await initializeDateFormatting('en');

  Intl.defaultLocale = await findSystemLocale();
}

void main({AppEnvironment environment}) async {
  if (kDebugMode) {
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  }

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  await setupLocalization();

  WidgetsFlutterBinding.ensureInitialized();

  final appConfig = await AppConfig.load(environment);
  setupContainer(appConfig);

  // Logger setup
  if (kDebugMode) {
    Logger.level = Level.debug;
  } else {
    Logger.level = Level.nothing;
  }

  //Setup Bloc logger
  if (kDebugMode) {
    Bloc.observer = SimpleBlocDelegate();
  }

  runApp(App());
}

class SimpleBlocDelegate extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    getLogger(bloc.runtimeType.toString()).i(transition);
  }
}
