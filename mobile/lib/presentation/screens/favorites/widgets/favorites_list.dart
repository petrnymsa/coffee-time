import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di_container.dart';
import '../../../../domain/entities/cafe.dart';
import '../../../shared/shared_widgets.dart';
import '../../detail/bloc/detail_bloc.dart';
import '../../detail/bloc/detail_bloc_event.dart' as detail_events;
import '../../detail/screen.dart';
import '../bloc/favorites_bloc.dart';
import '../bloc/favorites_bloc_event.dart';

class FavoritesList extends StatelessWidget {
  final List<Cafe> cafes;

  const FavoritesList({Key key, @required this.cafes}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cafes.length,
      itemBuilder: (_, index) => CafeTile(
        cafe: cafes[index],
        onFavoriteTap: () {
          context
              .bloc<FavoritesBloc>()
              .add(ToggleFavorite(cafes[index].placeId));
        },
        onTap: () => _onTileTap(context, cafes[index]),
      ),
    );
  }
}
