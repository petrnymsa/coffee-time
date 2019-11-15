import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/models/cafe.dart';
import 'package:coffee_time/presentation/screens/detail/detail.dart';
import 'package:coffee_time/presentation/screens/home/home_provider.dart';
import 'package:coffee_time/presentation/screens/home/tabs/favorites_provider.dart';
import 'package:coffee_time/presentation/shared/icons/hand_draw_icons_named.dart';
import 'package:coffee_time/presentation/shared/icons/hand_drawn_icons.dart';
import 'package:coffee_time/presentation/widgets/cafe_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getLogger('FavoritesTab').i('Build');
    return Consumer<FavoritesProvider>(
      builder: (ctx, model, child) {
        if (model.state == ProviderState.busy)
          return Center(
            child: CircularProgressIndicator(),
          );

        if (model.cafes.length == 0)
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

  Widget _buildCafeList(BuildContext context, FavoritesProvider model) {
    return ListView.builder(
      itemCount: model.cafes.length,
      itemBuilder: (_, i) => ChangeNotifierProvider.value(
        value: model.cafes[i],
        child: CafeTile(
          onFavoriteTap: () {
            model.removeFavorite(i);
          },
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                //todo push named route
                builder: (_) => DetailScreen(),
                settings: RouteSettings(arguments: model.cafes[i].entity.id)),
          ),
        ),
      ),
    );
  }
}
