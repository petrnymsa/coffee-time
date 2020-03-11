import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../di_container.dart';
import '../../../../domain/entities/cafe.dart';
import '../../../core/blocs/cafe_list/bloc.dart';
import '../../../shared/shared_widgets.dart';
import '../../detail/bloc/detail_bloc.dart';
import '../../detail/bloc/detail_bloc_event.dart' as detail_events;
import '../../detail/screen.dart';
import 'no_data.dart';

//todo add to current loaded state filter entity
class CafeList extends StatelessWidget {
  final List<Cafe> cafes;
  final String nextPageToken;

  const CafeList({
    Key key,
    @required this.cafes,
    this.nextPageToken,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cafes.length == 0) return NoData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              context.bloc<CafeListBloc>().add(Refresh());
              return Future.value();
            },
            child: NotificationListener(
              onNotification: (notification) =>
                  _handleScrollNotification(context, notification),
              child: ListView.builder(
                itemCount:
                    nextPageToken != null ? cafes.length + 1 : cafes.length,
                itemBuilder: (_, index) {
                  if (index < cafes.length) {
                    return CafeTile(
                      cafe: cafes[index],
                      onFavoriteTap: () {
                        context
                            .bloc<CafeListBloc>()
                            .add(ToggleFavorite(cafeId: cafes[index].placeId));
                      },
                      onTap: () => _onTileTap(context, cafes[index]),
                    );
                  } else {
                    return CircularLoader();
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool _handleScrollNotification(
      BuildContext context, Notification notification) {
    if (notification is ScrollEndNotification &&
        notification.metrics.extentAfter == 0) {
      context.bloc<CafeListBloc>().add(LoadNext(pageToken: nextPageToken));
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
}
