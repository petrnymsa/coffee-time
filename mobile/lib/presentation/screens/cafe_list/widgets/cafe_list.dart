import 'package:coffee_time/core/http_client_factory.dart';
import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/data/repositories/tag_repository.dart';
import 'package:coffee_time/data/services/cafe_service.dart';
import 'package:coffee_time/data/services/favorite_service.dart';
import 'package:coffee_time/data/services/photo_service.dart';
import 'package:coffee_time/data/services/tag_service.dart';
import 'package:coffee_time/domain/services/location_service.dart';
import 'package:coffee_time/presentation/screens/detail/bloc/detail_bloc.dart';
import 'package:coffee_time/presentation/screens/detail/bloc/detail_bloc_event.dart'
    as detailEvent;
import 'package:coffee_time/presentation/screens/detail/screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/app_logger.dart';
import '../../../../domain/entities/cafe.dart';
import '../../../core/blocs/cafe_list/bloc.dart';
import '../../../shared/shared_widgets.dart';
import 'no_data.dart';

//todo add to current loaded state filter entity
class CafeList extends StatefulWidget {
  final List<Cafe> cafes;
  final String nextPageToken;

  const CafeList({
    Key key,
    @required this.cafes,
    this.nextPageToken,
  }) : super(key: key);

  @override
  _CafeListState createState() => _CafeListState();
}

class _CafeListState extends State<CafeList> {
  final _scrollController = ScrollController();

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      context
          .bloc<CafeListBloc>()
          .add(LoadNext(pageToken: widget.nextPageToken));
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    getLogger('CafeList').i('rebuild');
    if (widget.cafes.length == 0) return NoData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text('Cafes total: ${widget.cafes.length}'),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () {
              context.bloc<CafeListBloc>().add(Refresh());
              return Future.value();
            },
            child: NotificationListener(
              onNotification: _handleScrollNotification,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: widget.nextPageToken != null
                    ? widget.cafes.length + 1
                    : widget.cafes.length,
                itemBuilder: (_, index) {
                  if (index < widget.cafes.length) {
                    //print('cafe i: $index');
                    return CafeTile(
                      cafe: widget.cafes[index],
                      onFavoriteTap: () {
                        context.bloc<CafeListBloc>().add(ToggleFavorite(
                            cafeId: widget.cafes[index].placeId));
                      },
                      onTap: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (ctx) => BlocProvider<DetailBloc>(
                              create: (_) => DetailBloc(
                                cafeListBloc: context.bloc<CafeListBloc>(),
                                cafe: widget.cafes[index],
                                cafeRepository: CafeRepositoryImpl(
                                  cafeService: CafeServiceImpl(
                                      clientFactory: HttpClientFactoryImpl()),
                                  favoriteService: FavoriteLocalService(),
                                  photoService: PhotoServiceImpl(),
                                  tagRepository: TagRepositoryImpl(
                                      tagService: TagServiceImpl(
                                          clientFactory:
                                              HttpClientFactoryImpl())),
                                ),
                              )..add(detailEvent.Load()),
                              child: DetailScreen(),
                            ),
                          ),
                        );
                      },
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
}
