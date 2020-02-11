import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/presentation/providers/cafe_list.dart';
import 'package:coffee_time/presentation/screens/detail/detail_provider.dart';
import 'package:coffee_time/presentation/screens/tags/add/tag_add_screen.dart';
import 'package:coffee_time/presentation/shared/shared_widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'tag_edit_provider.dart';

class TagEditScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailProvider>(
      builder: (ctx, detailModel, _) => Scaffold(
        appBar: AppBar(title: Text('Navrhnout změnu')),
        body: ChangeNotifierProvider<TagEditProvider>(
          builder: (_) => TagEditProvider([])..init(), //todo fix
          child: Consumer<TagEditProvider>(
            builder: (ctx, model, _) => Container(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildHeadline(context),
                    if (model.entityTags.isNotEmpty)
                      const SizedBox(
                        height: 30,
                      ),
                    if (model.entityTags.isNotEmpty)
                      Table(
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        // border: TableBorder.symmetric(
                        //     inside: BorderSide(color: Colors.)),
                        children: [
                          TableRow(
                              decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(color: Colors.black12)),
                              ),
                              children: [
                                Container(),
                                Text(
                                  'Pravda',
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Není pravda',
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  'Nehodnotím',
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                          ...model.entityTags
                              .map(
                                (t) => TableRow(
                                  decoration: BoxDecoration(
                                    border: Border(
                                        bottom:
                                            BorderSide(color: Colors.black12)),
                                  ),
                                  children: [
                                    TableCell(
                                      child: Text(
                                        t.title,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    _buildReviewIcon(
                                        t,
                                        FontAwesomeIcons.thumbsUp,
                                        true,
                                        model,
                                        context),
                                    _buildReviewIcon(
                                        t,
                                        FontAwesomeIcons.thumbsDown,
                                        false,
                                        model,
                                        context),
                                    _buildReviewIcon(t, FontAwesomeIcons.minus,
                                        null, model, context),
                                  ],
                                ),
                              )
                              .toList()
                        ],
                      ),
                    const SizedBox(
                      height: 30,
                    ),
                    // * add more
                    if (model.addedTags.length > 0)
                      ..._buildTagsToAdd(context, model),
                    if (model.notAddedTagsYet.length > 0)
                      RaisedButton.icon(
                        label: Text('Přidat štítky'),
                        icon: Icon(FontAwesomeIcons.plus),
                        onPressed: () async {
                          final addedTags = await Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: detailModel,
                              child: TagAddScreen(model.notAddedTagsYet),
                            ),
                          ));
                          if (addedTags != null) model.addTags(addedTags);
                        },
                      ),
                    FullWidthButton(
                      text: 'Potvrdit',
                      color: Colors.green,
                      icon: Icon(FontAwesomeIcons.check),
                      onPressed: () async {
                        await Provider.of<CafeListProvider>(context,
                                listen: false)
                            .addTags(
                                detailModel.detail, []); //todo fix empty []
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeadline(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          'Štítky jsou tvořeny uživateli.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.subhead,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Pomozte nám ',
              style: Theme.of(context).textTheme.subhead,
              children: [
                TextSpan(
                    text: 'zlepšit',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(
                  text: ' jejich přesnost.',
                )
              ]),
        ),
      ],
    );
  }

  Widget _buildReviewIcon(Tag tag, IconData icon, bool reviewType,
      TagEditProvider model, BuildContext context) {
    return TableCell(
        child: IconButton(
      icon: Icon(icon),
      color: model.reviewOfTag(tag) == reviewType
          ? Theme.of(context).primaryColor
          : Colors.grey,
      onPressed: () {
        model.updateReview(tag, reviewType);
      },
    ));
  }

  Widget _buildTag(Tag tag, TagEditProvider model) {
    return TagInput(
      tag: tag,
      onDeleted: () => model.removeTag(tag),
      onPressed: () => model.removeTag(tag),
    );
  }

  List<Widget> _buildTagsToAdd(BuildContext context, TagEditProvider model) {
    return <Widget>[
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
        children: model.addedTags
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
