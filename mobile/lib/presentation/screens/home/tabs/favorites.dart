import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/providers/cafe_list.dart';
import 'package:coffee_time/presentation/screens/detail/detail.dart';
import 'package:coffee_time/presentation/shared/icons/hand_draw_icons_named.dart';
import 'package:coffee_time/presentation/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getLogger('FavoritesTab').i('Build');
    return Consumer<CafeListProvider>(
      builder: (ctx, model, child) {
        if (model.state == ProviderState.busy)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (model.favoriteCafes.length == 0)
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  HandDrawnIconsNamed.HeartTwisted,
                  size: 48,
                ),
                SizedBox(
                  height: 14,
                ),
                Text(
                  'Žádné oblíbené kavárny',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          );
        return _buildCafeList(ctx, model);
      },
    );
  }

  Widget _buildCafeList(BuildContext context, CafeListProvider model) {
    return ListView.builder(
      itemCount: model.favoriteCafes.length,
      itemBuilder: (_, i) => ChangeNotifierProvider.value(
        value: model.favoriteCafes[i],
        child: CafeTile(onFavoriteTap: () {
          model.toggleFavorite(model.favoriteCafes[i]);
        }, onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                //todo push named route
                builder: (_) => DetailScreen(),
                settings:
                    RouteSettings(arguments: model.favoriteCafes[i].entity.id)),
          );
          model.refreshFavorites(); //! this
        }),
      ),
    );
  }
}
