import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/models/cafe.dart';
import 'package:coffee_time/presentation/providers/cafe_list.dart';
import 'package:coffee_time/presentation/screens/detail/detail.dart';
import 'package:coffee_time/presentation/shared/icons/hand_draw_icons_named.dart';
import 'package:coffee_time/presentation/shared/shared_widgets.dart';
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
    return Consumer<CafeListProvider>(
      builder: (ctx, model, child) {
        if (model.state == ProviderState.busy)
          return Center(
            child: CircularProgressIndicator(),
          );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (!model.currentFilter.isDefault())
              Center(
                child: Container(
                  padding: EdgeInsets.only(left: 30, top: 0, bottom: 0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Aktivní filtrování',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          model.updateFilter(FilterEntity.defaultFilter);
                        },
                      )
                    ],
                  ),
                ),
              ),
            if (model.mode == CafeListMode.Search)
              Center(
                child: Container(
                  padding: EdgeInsets.only(left: 30, top: 0, bottom: 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Kavárny na adrese ${model.searchQuery}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      IconButton(
                        padding: const EdgeInsets.all(0),
                        icon: Icon(Icons.cancel),
                        onPressed: () {
                          model.refreshByLocation();
                        },
                      )
                    ],
                  ),
                ),
              ),
            if (model.cafes == null || model.cafes.length == 0)
              Center(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Icon(HandDrawnIconsNamed.Cafe),
                      Text('Žádné kavárny neodpovídají hledání')
                    ],
                  ),
                ),
              ),
            if (model.cafes != null && model.cafes.length > 0)
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
        child: CafeTile(onFavoriteTap: () {
          Provider.of<CafeListProvider>(context, listen: false)
              .toggleFavorite(data[i]);
        }, onMapTap: () {
          // Provider.of<TabsProvider>(context, listen: false)
          //     .changeTab(CurrentTab.Map);
        }, onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
                //todo push named route
                builder: (_) => DetailScreen(),
                settings: RouteSettings(arguments: data[i].entity.id)),
          );
          Provider.of<CafeListProvider>(context, listen: false).refresh();
        }),
      ),
    );
  }
}
