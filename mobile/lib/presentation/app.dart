import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../di_container.dart';
import '../generated/i18n.dart';
import './screens/cafe_list/bloc/bloc.dart';
import 'core/blocs/filter/bloc.dart';
import 'core/blocs/tabs/bloc.dart';
import 'shared/theme.dart';
import 'shell.dart';

class App extends StatelessWidget {
  final _localizationDelegates = <LocalizationsDelegate>[
    I18n.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate // <-- needed for iOS
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FilterBloc>()..add(Init()),
      child: MaterialApp(
        title: 'Coffee Time',
        localizationsDelegates: _localizationDelegates,
        supportedLocales: I18n.delegate.supportedLocales,
        localeResolutionCallback:
            I18n.delegate.resolution(fallback: Locale("en", "US")),
        theme: AppTheme.apply(context),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<CafeListBloc>()..add(Refresh())),
            BlocProvider(create: (_) => TabsBloc()),
          ],
          child: Shell(),
        ),
      ),
    );
  }
}
