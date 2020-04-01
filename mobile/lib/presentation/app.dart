import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../bootstrapper.dart';
import '../core/firebase/authentication.dart';
import '../di_container.dart';
import '../generated/i18n.dart';
import './screens/cafe_list/bloc/bloc.dart';
import 'core/blocs/favorites/bloc.dart' as favorites_bloc;
import 'core/blocs/filter/bloc.dart';
import 'core/blocs/tabs/bloc.dart';
import 'screens/map/bloc/bloc.dart' as map_bloc;
import 'shared/theme.dart';

class App extends StatelessWidget {
  final _localizationDelegates = <LocalizationsDelegate>[
    I18n.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate // <-- needed for iOS
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<FilterBloc>()..add(Init()),
        ),
        BlocProvider(
          create: (_) =>
              sl<favorites_bloc.FavoritesBloc>()..add(favorites_bloc.Load()),
        ),
        BlocProvider(create: (_) => sl<CafeListBloc>()..add(Refresh())),
      ],
      child: MaterialApp(
        title: 'Coffee Time',
        localizationsDelegates: _localizationDelegates,
        supportedLocales: I18n.delegate.supportedLocales,
        localeResolutionCallback:
            I18n.delegate.resolution(fallback: Locale("en", "US")),
        theme: AppTheme.apply(context),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (_) => sl<map_bloc.MapBloc>()..add(map_bloc.Init())),
            BlocProvider(create: (_) => TabsBloc()),
          ],
          child: Bootstrapper(authProvider: sl<FirebaseAuthProvider>()),
        ),
      ),
    );
  }
}
