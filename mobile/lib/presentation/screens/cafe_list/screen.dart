import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/blocs/cafe_list/bloc.dart';
import '../../shared/shared_widgets.dart';
import 'widgets/cafe_list.dart';
import 'widgets/loading.dart';

class CafeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CafeListBloc, CafeListState>(
      builder: (context, state) {
        print('got new state');
        return state.when(
          loading: () => CenteredLoading(),
          loaded: (cafes, token) {
            return CafeList(
              cafes: cafes,
              nextPageToken: token,
            );
          },
          failure: (message) => FailureMessage(
            message: message,
          ),
        );
      },
    );
  }
}
