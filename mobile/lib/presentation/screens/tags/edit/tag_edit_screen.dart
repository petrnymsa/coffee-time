import 'package:coffee_time/core/app_logger.dart';
import 'package:coffee_time/domain/entities/tag.dart';
import 'package:coffee_time/presentation/providers/cafe_list.dart';
import 'package:coffee_time/presentation/screens/detail/detail_provider.dart';
import 'package:coffee_time/presentation/screens/tags/add/tag_add_provider.dart';
import 'package:coffee_time/presentation/screens/tags/add/tag_add_screen.dart';
import 'package:coffee_time/presentation/widgets/tag_container.dart';
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
          builder: (_) => TagEditProvider(detailModel.detail.tags)..init(),
          child: Consumer<TagEditProvider>(
            builder: (ctx, model, _) => Container(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    _buildHeadline(context),
                    const SizedBox(
                      height: 30,
                    ),
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
                                  _buildReviewIcon(t, FontAwesomeIcons.thumbsUp,
                                      true, model, context),
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
                    if (model.addedTags.length == 0)
                      ..._buildNoTagsToAdd(context, model),
                    // Text(
                    //   'Některý štítek chybí?',
                    //   style: Theme.of(context).textTheme.subhead,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
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
                            getLogger('TagEditScreen')
                                .i('add new tags $addedTags');
                            if (addedTags != null) model.addTags(addedTags);
                          },
                        ),
                        SizedBox(
                          width: 26,
                        ),
                        if (model.addedTags.length > 0)
                          RaisedButton.icon(
                            label: Text('Vyčistit'),
                            icon: Icon(FontAwesomeIcons.recycle),
                            onPressed: () {
                              model.clearTags();
                            },
                          )
                      ],
                    ),

                    const SizedBox(
                      height: 60,
                    ),
                    // RaisedButton.icon(
                    //   label: Text('Potvrdit'),
                    //   icon: Icon(FontAwesomeIcons.check),
                    //   onPressed: () {},
                    // )
                  ],
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            FontAwesomeIcons.check,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
      ),
    );
  }

  List<Widget> _buildTagsToAdd(BuildContext context, TagEditProvider model) {
    return <Widget>[
      Text(
        'Štítky k přidání',
        style: Theme.of(context).textTheme.subhead,
      ),
      Divider(),
      const SizedBox(
        height: 4,
      ),
      Wrap(
        alignment: WrapAlignment.start,
        children: model.addedTags
            .map((t) => TagContainer(
                  icon: t.icon,
                  title: t.title,
                ))
            .toList(),
      ),
      const SizedBox(
        height: 4,
      ),
    ];
  }

  List<Widget> _buildNoTagsToAdd(BuildContext context, TagEditProvider model) {
    // return <Widget>[
    //   Text(
    //     'Některý štítek chybí?',
    //     style: Theme.of(context).textTheme.subhead,
    //   ),
    // ];
    return [];
  }

  Widget _buildReviewIcon(TagEntity tag, IconData icon, bool reviewType,
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
}
