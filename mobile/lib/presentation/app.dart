import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../di_container.dart';
import '../generated/i18n.dart';
import 'core/blocs/cafe_list/bloc.dart';
import 'core/blocs/tabs/bloc.dart';
import 'shared/theme.dart';
import 'shell.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.delegate;
    return MaterialApp(
      title: 'Coffee Time',
      localizationsDelegates: [
        i18n,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate // <-- needed for iOS
      ],
      supportedLocales: i18n.supportedLocales,
      localeResolutionCallback: i18n.resolution(fallback: Locale("en", "US")),
      theme: AppTheme.apply(context),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => sl<CafeListBloc>()..add(Refresh()),
          ),
          BlocProvider(
            create: (_) => TabsBloc(),
          ),
        ],
        child: Shell(),
      ),
    );
  }
}
