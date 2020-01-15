import 'package:coffee_time/domain/entities/filter.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/presentation/providers/cafe_list.dart';
import 'package:coffee_time/presentation/screens/filter/filter_provider.dart';
import 'package:coffee_time/presentation/screens/tags/add/tag_add_screen.dart';
import 'package:coffee_time/presentation/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class FilterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cafeListProvider =
        Provider.of<CafeListProvider>(context, listen: false);

    return ChangeNotifierProvider(
      builder: (_) => FilterProvider(cafeListProvider)..init(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Upravit filtr'),
        ),
        floatingActionButton: Builder(
          builder: (ctx) => FloatingActionButton.extended(
            icon: Icon(Icons.check),
            label: Text('Potvrdit'),
            foregroundColor: Colors.white,
            onPressed: () {
              Provider.of<FilterProvider>(ctx, listen: false).save();
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Consumer<FilterProvider>(
          builder: (ctx, model, _) => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 60.0),
              child: Column(
                children: <Widget>[
                  ..._buildOpening(ctx, model),
                  SectionHeader(
                    title: 'Řazení',
                    icon: Icons.sort,
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                        groupValue: model.filter.ordering.index,
                        value: FilterOrdering.distance.index,
                        onChanged: (v) => model.changeOrdering(v),
                      ),
                      GestureDetector(
                        onTap: () =>
                            model.changeOrdering(FilterOrdering.distance.index),
                        child: Text(
                          'Podle vzdálenosti',
                          style: Theme.of(context).textTheme.subhead,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Radio(
                        groupValue: model.filter.ordering.index,
                        value: FilterOrdering.rating.index,
                        onChanged: (v) => model.changeOrdering(v),
                      ),
                      GestureDetector(
                        onTap: () =>
                            model.changeOrdering(FilterOrdering.rating.index),
                        child: Text(
                          'Podle hodnocení',
                          style: Theme.of(context).textTheme.subhead,
                        ),
                      ),
                    ],
                  ),
                  SectionHeader(
                    icon: FontAwesomeIcons.tags,
                    title: 'Štítky',
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Text('Kavárna obsahuje alespoň jeden níže vybraný štítek'),
                  if (model.filter.tags != null) ..._buildTagsToAdd(ctx, model),
                  if (model.notAddedTagsYet.length > 0)
                    RaisedButton.icon(
                      label: Text('Vybrat štítky'),
                      icon: Icon(FontAwesomeIcons.plus),
                      onPressed: () async {
                        final List<TagEntity> addedTags =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => TagAddScreen(
                                      model.notAddedTagsYet,
                                      title: 'Vybrat štítky',
                                    )));
                        if (addedTags != null)
                          model.updateChosenTags(addedTags);
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildOpening(BuildContext context, FilterProvider model) {
    return [
      SectionHeader(
        icon: FontAwesomeIcons.clock,
        title: 'Otevírací doba',
      ),
      Row(
        children: <Widget>[
          GestureDetector(
            onTap: () => model.changeOnlyNow(!model.filter.onlyOpen),
            child: Text(
              'Pouze otevřené',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          Switch(
            value: model.filter.onlyOpen,
            onChanged: (value) => model.changeOnlyNow(value),
          )
        ],
      )
    ];
  }

  Widget _buildTag(TagEntity tag, FilterProvider model) {
    return TagInput(
      tag: tag,
      onDeleted: () => model.updateChosenTag(tag),
      onPressed: () => model.updateChosenTag(tag),
    );
  }

  List<Widget> _buildTagsToAdd(BuildContext context, FilterProvider model) {
    return <Widget>[
      if (model.filter.tags.length > 0)
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Štítky k přidání',
              style: Theme.of(context).textTheme.subhead,
            ),
            FlatButton.icon(
              label: Text('Vyčistit'),
              icon: Icon(Icons.clear_all),
              onPressed: () {
                model.clearTags();
              },
            )
          ],
        ),
      Divider(),
      Wrap(
        alignment: WrapAlignment.start,
        spacing: 6.0,
        runSpacing: 0.0,
        children: model.filter.tags
            .map(
              (t) => _buildTag(t, model),
            )
            .toList(),
      ),
      const SizedBox(
        height: 4,
      ),
    ];
  }
}
