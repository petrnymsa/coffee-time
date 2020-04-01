import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../domain/entities/tag.dart';
import '../../../generated/i18n.dart';
import '../../shared/shared_widgets.dart';
import 'bloc/bloc.dart';

class TagsChooseScreen extends StatelessWidget {
  const TagsChooseScreen({Key key}) : super(key: key);

  void _onTagSelected(BuildContext context, Tag tag) {
    context.bloc<TagsChooseBloc>().add(ChooseTag(tag: tag));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(I18n.of(context).addTags_title)),
      body: BlocBuilder<TagsChooseBloc, TagsChooseBlocState>(
        builder: (context, state) => Container(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(I18n.of(context).addTags_header),
                Align(
                  alignment: Alignment.topCenter,
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    alignment: WrapAlignment.center,
                    children: state.availableTags
                        .map((tag) => TagChoice(
                              tag: tag,
                              padding: const EdgeInsets.all(2.0),
                              selected: state.chosenTags.contains(tag),
                              onSelected: (_) => _onTagSelected(context, tag),
                            ))
                        .toList(),
                  ),
                ),
                FullWidthButton(
                  text: I18n.of(context).confirm,
                  color: Colors.green,
                  icon: const FaIcon(FontAwesomeIcons.check),
                  onPressed: () async {
                    Navigator.of(context).pop(state.chosenTags);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
