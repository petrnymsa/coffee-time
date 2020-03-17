import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'widgets/widgets.dart';

//todo translate
class FilterScreen extends StatelessWidget {
  const FilterScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterBlocState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text('Upravit filtr'),
        ),
        floatingActionButton: Builder(
          builder: (ctx) => FloatingActionButton.extended(
            icon: Icon(Icons.check),
            label: Text('Potvrdit'),
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pop(state.filter);
            },
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
    );
  }
}
