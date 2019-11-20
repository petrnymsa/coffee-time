import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/presentation/providers/cafe_list.dart';
import 'package:coffee_time/presentation/screens/detail/detail_provider.dart';
import 'package:coffee_time/presentation/screens/tags/add/tag_add_provider.dart';
import 'package:coffee_time/presentation/widgets/full_width_button.dart';
import 'package:coffee_time/presentation/widgets/tag/tag_choice.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TagAddScreen extends StatelessWidget {
  final List<TagEntity> availableTags;
  final String title;

  TagAddScreen(this.availableTags, {this.title = 'Přidat štítky'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
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
                FullWidthButton(
                  text: 'Potvrdit',
                  color: Colors.green,
                  icon: Icon(FontAwesomeIcons.check),
                  onPressed: () async {
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
    // return Padding(
    //   padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
    //   child: ChoiceChip(
    //       padding: const EdgeInsets.all(10.0),
    //       label: Text(tag.title),
    //       selected: model.chosenTags.contains(tag),
    //       avatar: model.chosenTags.contains(tag)
    //           ? Icon(
    //               FontAwesomeIcons.check,
    //               size: 16,
    //             )
    //           : Icon(tag.icon, size: 16),
    //       onSelected: (bool _) => model.update(tag)),
    // );
    return TagChoice(
      tag: tag,
      selected: model.chosenTags.contains(tag),
      onSelected: (bool _) => model.update(tag),
    );
  }
}
