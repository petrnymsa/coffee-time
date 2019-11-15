import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/models/cafe.dart';
import 'package:coffee_time/presentation/screens/detail/detail.dart';
import 'package:coffee_time/presentation/screens/home/home_provider.dart';
import 'package:coffee_time/presentation/widgets/cafe_tile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CafeListTab extends StatefulWidget {
  CafeListTab({Key key}) : super(key: key);

  @override
  _CafeListTabState createState() => _CafeListTabState();
}

class _CafeListTabState extends State<CafeListTab> {
  @override
  Widget build(BuildContext context) {
    getLogger('CafeListTab').i('Build');
    return Consumer<HomeProvider>(
      builder: (ctx, model, child) {
        if (model.state == ProviderState.busy)
          return Center(
            child: CircularProgressIndicator(),
          );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (model.mode == HomeFilterMode.Search)
              Center(
                child: Container(
                  padding: EdgeInsets.only(left: 30),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Kavárny na adrese ${model.searchQuery}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      IconButton(
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          model.refreshByLocation();
                        },
                      )
                    ],
                  ),
                ),
              ),
            Expanded(child: _buildCafeList(ctx, model.cafes)),
          ],
        );
      },
    );
  }

  Widget _buildCafeList(BuildContext context, List<Cafe> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (_, i) => ChangeNotifierProvider.value(
        value: data[i],
        child: CafeTile(
            onFavoriteTap: () => data[i].toggleFavorite(),
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    //todo push named route
                    builder: (_) => DetailScreen(),
                    settings: RouteSettings(arguments: data[i].entity.id)),
              );
              Provider.of<HomeProvider>(context, listen: false).refresh();
            }),
      ),
    );
  }
}
