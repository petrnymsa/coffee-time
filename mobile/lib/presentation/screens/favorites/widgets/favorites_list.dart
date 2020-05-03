import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di_container.dart';
import '../../../../domain/entities/cafe.dart';
import '../../../../domain/entities/location.dart';
import '../../../../domain/services/location_service.dart';
import '../../../core/blocs/favorites/bloc.dart';
import '../../../core/notification_helper.dart';
import '../../../shared/shared_widgets.dart';
import '../../detail/bloc/detail_bloc.dart';
import '../../detail/bloc/detail_bloc_event.dart' as detail_events;
import '../../detail/screen.dart';

class FavoritesList extends StatelessWidget {
  final List<Cafe> cafes;

  const FavoritesList({Key key, @required this.cafes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _location(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: cafes.length,
            itemBuilder: (_, index) => CafeTile(
              currentLocation: snapshot.data,
              cafe: cafes[index],
              onFavoriteTap: () => _onToggleFavorite(context, cafes[index]),
              onTap: () => _onTileTap(context, cafes[index]),
            ),
          );
        }
        return const CircularLoader();
      },
    );
  }

  //todo add named route
  void _onTileTap(BuildContext context, Cafe cafe) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => BlocProvider<DetailBloc>(
          create: (_) => sl.get<DetailBloc>(
            param1: cafe,
          )..add(detail_events.Load()),
          child: DetailScreen(),
        ),
      ),
    );
  }

  void _onToggleFavorite(BuildContext context, Cafe cafe) {
    final favoritesBloc = context.bloc<FavoritesBloc>();

    favoritesBloc.add(ToggleFavorite(cafe.placeId));

    context.showFavoriteChangedSnackBar(
      isFavorite: cafe.isFavorite,
      duration: const Duration(seconds: 3),
      undoAction: () => favoritesBloc.add(ToggleFavorite(cafe.placeId)),
    );
  }

  Future<Location> _location() => sl<LocationService>().getCurrentLocation();
}
