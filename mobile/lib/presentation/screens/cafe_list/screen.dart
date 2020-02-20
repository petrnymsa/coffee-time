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
        return state.when(
          loading: () => CenteredLoading(),
          loaded: (cafes) => CafeList(
            cafes: cafes,
          ),
          failure: (message) => FailureMessage(
            message: message,
          ),
        );
      },
    );
  }
}
