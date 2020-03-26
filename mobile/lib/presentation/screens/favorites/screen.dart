import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/blocs/favorites/bloc.dart';
import '../../shared/shared_widgets.dart';
import 'widgets/widgets.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesBloc, FavoritesBlocState>(
      builder: (context, state) {
        return state.when(
          loading: () => CircularLoader(),
          loaded: (cafes, _, __) {
            if (cafes.length == 0) {
              return NoFavorites();
            }

            return FavoritesList(cafes: cafes);
          },
          failure: (msg) => FailureContainer(
            message: msg,
            onRefresh: () {
              context.bloc<FavoritesBloc>().add(Load());
            },
          ),
        );
      },
    );
  }
}
