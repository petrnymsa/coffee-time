import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/presentation/providers/cafe_list.dart';
import 'package:coffee_time/presentation/screens/detail/detail_provider.dart';
import 'package:coffee_time/presentation/screens/tags/add/tag_add_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TagAddScreen extends StatelessWidget {
  final List<TagEntity> availableTags;

  TagAddScreen(this.availableTags);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Přidat štítky')),
      body: ChangeNotifierProvider(
        builder: (_) => TagAddProvider(availableTags)..init(),
        child: Consumer<TagAddProvider>(
          builder: (ctx, model, _) => Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text('Vyberte jeden nebo víc štítků'),
                Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: model.availableTags
                        .map((t) => _buildTag(t, model))
                        .toList(),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  child: Text('Přidat'),
                  padding: const EdgeInsets.symmetric(horizontal: 86.0),
                  onPressed: () async {
                    // await Provider.of<CafeListProvider>(context,
                    //         listen: false)
                    //     .addTags(detailModel.detail, model.chosenTags);
                    Navigator.pop(context, model.chosenTags);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTag(TagEntity tag, TagAddProvider model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: ChoiceChip(
          padding: const EdgeInsets.all(10.0),
          label: Text(tag.title),
          selected: model.chosenTags.contains(tag),
          avatar: model.chosenTags.contains(tag)
              ? Icon(
                  FontAwesomeIcons.check,
                  size: 16,
                )
              : Icon(tag.icon, size: 16),
          onSelected: (bool _) => model.update(tag)),
    );
  }
}
