import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/presentation/screens/tags/add/tag_add_provider.dart';
import 'package:coffee_time/presentation/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TagAddScreen extends StatelessWidget {
  final List<Tag> availableTags;
  final String title;

  TagAddScreen(this.availableTags, {this.title = 'Přidat štítky'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ChangeNotifierProvider(
        create: (_) => TagAddProvider(availableTags),
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

  Widget _buildTag(Tag tag, TagAddProvider model) {
    return TagChoice(
      tag: tag,
      selected: model.chosenTags.contains(tag),
      onSelected: (bool _) => model.update(tag),
    );
  }
}
