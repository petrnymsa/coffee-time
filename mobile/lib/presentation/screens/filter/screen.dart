import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../generated/i18n.dart';
import '../../core/blocs/filter/bloc.dart';
import 'widgets/widgets.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({Key key}) : super(key: key);

  void _handleAppBarBack(BuildContext context) {
    context.read<FilterBloc>().add(Confirm());
    Navigator.of(context).pop();
  }

  Future<bool> _handleBackButton(BuildContext context) async {
    context.read<FilterBloc>().add(Confirm());
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _handleBackButton(context),
      child: BlocBuilder<FilterBloc, FilterBlocState>(
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(I18n.of(context).filter_title),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => _handleAppBarBack(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 60.0),
              child: Column(
                children: <Widget>[
                  OpeningHoursContainer(filter: state.filter),
                  OrderingContainer(ordering: state.filter.ordering),
                  TagsContainer(state: state),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
