import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/blocs/cafe_list/bloc.dart';
import '../../shared/shared_widgets.dart';
import 'widgets/widgets.dart';

class CafeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CafeListBloc, CafeListState>(
      builder: (context, state) {
        return state.when(
          loading: () => CircularLoader(),
          loaded: (cafes, token) {
            if (cafes.length == 0) {
              return NoData();
            }

            return CafeList(
              cafes: cafes,
              nextPageToken: token,
            );
          },
          failure: (message) => FailureContainer(
            message: message,
            onRefresh: () {
              context.bloc<CafeListBloc>().add(Refresh());
            },
          ),
        );
      },
    );
  }
}
