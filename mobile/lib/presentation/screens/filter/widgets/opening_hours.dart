import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../domain/entities/filter.dart';
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
            title: 'Otevírací doba',
          ),
          Row(
            children: <Widget>[
              GestureDetector(
                onTap: () =>
                    context.bloc<FilterBloc>().add(ChangeOpeningHour()),
                child: Text(
                  'Pouze otevřené',
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
              Switch(
                value: filter.onlyOpen, //model.filter.onlyOpen,
                onChanged: (value) =>
                    context.bloc<FilterBloc>().add(ChangeOpeningHour()),
              )
            ],
          ),
        ],
      ),
    );
  }
}
