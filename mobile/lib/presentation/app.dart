import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../di_container.dart';
import 'core/blocs/cafe_list/bloc.dart';
import 'core/blocs/tabs/bloc.dart';
import 'shared/theme.dart';
import 'shell.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Time',
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
