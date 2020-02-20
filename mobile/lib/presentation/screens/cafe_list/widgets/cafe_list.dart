import 'package:coffee_time/presentation/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/entities/cafe.dart';

//todo add to current loaded state filter entity
class CafeList extends StatelessWidget {
  final List<Cafe> cafes;

  const CafeList({Key key, this.cafes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cafes.length == 0) return _buildNoData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        // if (model.mode == CafeListMode.Search) _buildActiveSearch(model),
        Expanded(
          child: ListView.builder(
            itemCount: cafes.length,
            itemBuilder: (_, i) {
              // if (!model.currentFilter.isDefault() && i == 0) {
              //   return _buildFilter(model);
              // } else

              // final cafeIndex = model.currentFilter.
              //isDefault() ? i : i - 1;
              return CafeTile(
                cafe: cafes[i],
                onFavoriteTap: () {
                  // Provider.of<CafeListProvider>(context, listen: false)
                  //     .toggleFavorite(data[i]);
                },
                onTap: () async {
                  print('clicked show detail');
                  // await Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       //todo push named route
                  //       builder: (_) => DetailScreen(),
                  //       settings: RouteSettings(
                  //           arguments: data[cafeIndex].entity.placeId)),
                  // );
                  // Provider.of<CafeListProvider>(context, listen: false)
                  //.refresh();
                },
              );
            },
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
