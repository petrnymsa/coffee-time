import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/filter.dart';
import '../../../../generated/i18n.dart';
import '../../../shared/shared_widgets.dart';
import '../bloc/bloc.dart';

class OrderingContainer extends StatelessWidget {
  final FilterOrdering ordering;

  const OrderingContainer({Key key, @required this.ordering}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SectionHeader(
            title: I18n.of(context).filter_orderBy_title,
            icon: Icons.sort,
          ),
          const SizedBox(height: 6.0),
          Row(
            children: <Widget>[
              Radio(
                groupValue: ordering.index,
                value: FilterOrdering.distance.index,
                onChanged: (_) =>
                    context.bloc<FilterBloc>().add(ChangeOrdering()),
              ),
              GestureDetector(
                onTap: () => context.bloc<FilterBloc>().add(ChangeOrdering()),
                child: Text(
                  I18n.of(context).filter_orderBy_distance,
                  style: Theme.of(context).textTheme.subhead,
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                groupValue: ordering.index,
                value: FilterOrdering.popularity.index,
                onChanged: (v) =>
                    context.bloc<FilterBloc>().add(ChangeOrdering()),
              ),
              GestureDetector(
                onTap: () => context.bloc<FilterBloc>().add(ChangeOrdering()),
                child: Text(
                  I18n.of(context).filter_orderBy_popularity,
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
