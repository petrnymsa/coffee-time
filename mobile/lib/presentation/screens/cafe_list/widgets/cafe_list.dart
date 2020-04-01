import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di_container.dart';
import '../../../../domain/entities/cafe.dart';
import '../../../core/blocs/favorites/bloc.dart' as favorites;
import '../../../core/notification_helper.dart';
import '../../../shared/shared_widgets.dart';
import '../../detail/bloc/detail_bloc.dart';
import '../../detail/bloc/detail_bloc_event.dart' as detail_events;
import '../../detail/screen.dart';
import '../bloc/bloc.dart';
import 'no_data.dart';

class CafeList extends StatelessWidget {
  final Loaded state;

  const CafeList({
    Key key,
    @required this.state,
  }) : super(key: key);

  void _onToggleFavorite(BuildContext context, Cafe cafe) {
    //  context.bloc<CafeListBloc>().add(ToggleFavorite(cafeId: cafe.placeId));
    context
        .bloc<favorites.FavoritesBloc>()
        .add(favorites.ToggleFavorite(cafe.placeId));
    context.showFavoriteChangedSnackBar(isFavorite: cafe.isFavorite);
  }

  bool _handleScrollNotification(
      BuildContext context, Notification notification) {
    if (notification is ScrollEndNotification &&
        notification.metrics.extentAfter == 0) {
      context.bloc<CafeListBloc>().add(
          LoadNext(pageToken: state.nextPageToken, filter: state.actualFilter));
    }

    return false;
  }

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
    if (state.cafes.length == 0) return NoData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              context
                  .bloc<CafeListBloc>()
                  .add(Refresh(filter: state.actualFilter));
              return Future.value();
            },
            child: NotificationListener(
              onNotification: (notification) =>
                  _handleScrollNotification(context, notification),
              child: ListView.builder(
                itemCount: state.nextPageToken != null
                    ? state.cafes.length + 1
                    : state.cafes.length,
                itemBuilder: (_, index) {
                  if (index < state.cafes.length) {
                    return CafeTile(
                      cafe: state.cafes[index],
                      currentLocation: state.currentLocation,
                      onFavoriteTap: () =>
                          _onToggleFavorite(context, state.cafes[index]),
                      onTap: () => _onTileTap(context, state.cafes[index]),
                    );
                  } else {
                    return const CircularLoader();
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
