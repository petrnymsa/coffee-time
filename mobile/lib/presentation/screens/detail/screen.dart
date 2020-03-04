import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../../core/app_logger.dart';
import '../../shared/shared_widgets.dart';
import 'bloc/detail_bloc.dart';
import 'bloc/detail_bloc_state.dart';
import 'widgets/widgets.dart';

class DetailScreen extends StatelessWidget {
  final Logger logger = getLogger('DetailScreen');

  DetailScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailBloc, DetailBlocState>(
        builder: (context, state) {
          return state.when(
            loading: () => CircularLoader(),
            failure: (message) => FailureMessage(message: message),
            loaded: (cafe, detail) => DetailContainer(
              logger: logger,
              cafe: cafe,
              detail: detail,
            ),
          );
        },
      ),
      floatingActionButton: BlocBuilder<DetailBloc, DetailBlocState>(
        builder: (context, state) => state.maybeWhen(
            loaded: (cafe, detail) => FavoriteButton(cafe: cafe),
            orElse: () => Container(width: 0.0, height: 0.0)),
      ),
    );
  }
}
