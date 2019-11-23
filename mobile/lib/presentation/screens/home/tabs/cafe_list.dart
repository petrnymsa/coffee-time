import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/models/cafe.dart';
import 'package:coffee_time/presentation/providers/cafe_list.dart';
import 'package:coffee_time/presentation/screens/detail/detail.dart';
import 'package:coffee_time/presentation/shared/icons/hand_draw_icons_named.dart';
import 'package:coffee_time/presentation/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            if (model.mode == CafeListMode.Search) _buildActiveSearch(model),
            Expanded(child: _buildCafeList(ctx, model)),
          ],
        );
      },
    );
  }

  Center _buildActiveSearch(CafeListProvider model) {
    return Center(
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
    );
  }

  Widget _buildNoData() {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: <Widget>[
          Icon(HandDrawnIconsNamed.Cafe),
          Text('Žádné kavárny neodpovídají hledání')
        ],
      ),
    );
  }

  Widget _buildFilter(CafeListProvider model) {
    final filter = model.currentFilter;

    return Container(
      padding: const EdgeInsets.only(top: 10.0, left: 10),
      child: ExpandablePanel(
        expanded: true,
        header: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Text(
                'Aktivní filtrování',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.subhead,
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.timesCircle, size: 16),
                onPressed: () => model.updateFilter(FilterEntity.defaultFilter),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(FontAwesomeIcons.clock),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  filter.onlyOpen ? 'Pouze otevřené' : 'Včetně zavřených',
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            if (filter.tags.length > 0) _buildFilterTags(model),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTags(CafeListProvider model) {
    final tags = model.currentFilter.tags;

    _removeTag(TagEntity t) {
      tags.remove(t);
      model.updateFilter(model.currentFilter.copyWith(tags: tags));
    }

    return Wrap(
      spacing: 2.0,
      runSpacing: 0,
      children: tags
          .map((t) => TagInput(
                tag: t,
                onPressed: () => _removeTag(t),
                onDeleted: () => _removeTag(t),
              ))
          .toList(),
    );
  }

  Widget _buildCafeList(BuildContext context, CafeListProvider model) {
    final data = model.cafes;
    var length =
        model.currentFilter.isDefault() ? data.length : data.length + 1;
    if (data.length == 0) length += 1;
    print('Length of list: $length');
    return ListView.builder(
        itemCount: length,
        itemBuilder: (_, i) {
          if (!model.currentFilter.isDefault() && i == 0)
            return _buildFilter(model);
          else if (data.length == 0) {
            return _buildNoData();
          } else {
            final cafeIndex = model.currentFilter.isDefault() ? i : i - 1;
            return ChangeNotifierProvider.value(
              value: data[cafeIndex],
              child: CafeTile(onFavoriteTap: () {
                Provider.of<CafeListProvider>(context, listen: false)
                    .toggleFavorite(data[i]);
              }, onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      //todo push named route
                      builder: (_) => DetailScreen(),
                      settings:
                          RouteSettings(arguments: data[cafeIndex].entity.id)),
                );
                Provider.of<CafeListProvider>(context, listen: false).refresh();
              }),
            );
          }
        });
  }
}
