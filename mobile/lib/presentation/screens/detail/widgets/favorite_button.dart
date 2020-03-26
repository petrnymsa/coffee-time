import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/cafe.dart';
import '../../../core/blocs/favorites/bloc.dart' as favorites;
import '../../../core/notification_helper.dart';

class FavoriteButton extends StatelessWidget {
  final Cafe cafe;
  const FavoriteButton({
    Key key,
    @required this.cafe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(
        cafe.isFavorite ? Icons.favorite : Icons.favorite_border,
        size: 32,
        color: Colors.white,
      ),
      onPressed: () {
        // context.bloc<DetailBloc>().add(ToggleFavorite(cafe.placeId));
        context
            .bloc<favorites.FavoritesBloc>()
            .add(favorites.ToggleFavorite(cafe.placeId));
        context.showFavoriteChangedSnackBar(isFavorite: cafe.isFavorite);
      },
    );
  }
}
