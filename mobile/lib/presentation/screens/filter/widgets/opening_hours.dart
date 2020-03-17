import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/entities/filter.dart';
import '../../../../generated/i18n.dart';
import '../../../shared/shared_widgets.dart';
import '../bloc/bloc.dart';

class OpeningHoursContainer extends StatelessWidget {
  final Filter filter;
  const OpeningHoursContainer({
    Key key,
    @required this.filter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SectionHeader(
            icon: FontAwesomeIcons.clock,
            title: I18n.of(context).filter_openingHours_title,
          ),
          Row(
            children: <Widget>[
              Switch(
                value: filter.onlyOpen, //model.filter.onlyOpen,
                onChanged: (value) =>
                    context.bloc<FilterBloc>().add(ChangeOpeningHour()),
              ),
              GestureDetector(
                onTap: () =>
                    context.bloc<FilterBloc>().add(ChangeOpeningHour()),
                child: Text(
                  I18n.of(context).filter_openingHours_onlyOpen,
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
