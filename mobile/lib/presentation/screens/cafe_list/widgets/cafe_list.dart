import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/presentation/core/blocs/cafe_list/bloc.dart';
import 'package:coffee_time/presentation/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/cafe.dart';

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

  @override
  void initState() {
    getLogger('CafeList').i('initState');
    //  _scrollController.addListener(_onScroll);
    super.initState();
  }

  // void _onScroll() {
  //   final maxScroll = _scrollController.position.maxScrollExtent;
  //   final currentScroll = _scrollController.position.pixels;
  //   if (maxScroll - currentScroll <= 200) {
  //     context.bloc<CafeListBloc>().add(LoadNext(widget.nextPageToken));
  //   }
  // }

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
    if (widget.cafes.length == 0) return _buildNoData();

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
                        // Provider.of<CafeListProvider>(context, listen: false)
                        //     .toggleFavorite(data[i]);
                      },
                      onTap: () async {
                        print('clicked show detail');
                      },
                    );
                  } else {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 1,
                      ),
                    ));
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoData() {
    return Center(
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: <Widget>[
            Icon(FontAwesomeIcons.coffee),
            Text('Žádné kavárny neodpovídají hledání') //todo translate
          ],
        ),
      ),
    );
  }
}
