import 'package:coffee_time/core/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/blocs/cafe_list/bloc.dart';
import '../../shared/shared_widgets.dart';
import 'widgets/cafe_list.dart';

class CafeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CafeListBloc, CafeListState>(
      builder: (context, state) {
        return state.when(
          loading: () => CircularLoader(),
          loaded: (cafes, token) {
            getLogger('CafeListScreen').i('got state ${cafes[0].isFavorite}');
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
