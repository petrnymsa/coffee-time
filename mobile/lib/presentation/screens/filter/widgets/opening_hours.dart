import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/entities/filter.dart';
import '../../../../generated/i18n.dart';
import '../../../core/blocs/filter/bloc.dart';
import '../../../shared/shared_widgets.dart';

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
                value: filter.onlyOpen,
                onChanged: (value) {
                  final b = BlocProvider.of<FilterBloc>(context);
                  b.add(ChangeOpeningHour());
                  //context.read<FilterBloc>().add(ChangeOpeningHour());
                },
              ),
              GestureDetector(
                onTap: () =>
                    context.read<FilterBloc>().add(ChangeOpeningHour()),
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
