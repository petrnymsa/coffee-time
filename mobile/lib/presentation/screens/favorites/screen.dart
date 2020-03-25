import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_logger.dart';
import '../../shared/shared_widgets.dart';
import 'bloc/bloc.dart';
import 'widgets/widgets.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getLogger('FavoritesTab').i('Build');
    return BlocBuilder<FavoritesBloc, FavoritesBlocState>(
      builder: (context, state) {
        return state.when(
          loading: () => CircularLoader(),
          loaded: (cafes) {
            if (cafes.length == 0) {
              return NoFavorites();
            }

            return FavoritesList(cafes: cafes);
          },
          failure: (msg) => FailureMessage(message: msg),
        );
      },
    );
  }
}
