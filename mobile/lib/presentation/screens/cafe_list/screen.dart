import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/app_logger.dart';
import '../../shared/shared_widgets.dart';
import './bloc/bloc.dart';
import 'widgets/widgets.dart';

class CafeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    getLogger('CafeListScreen').i('rebuild');
    return BlocBuilder<CafeListBloc, CafeListState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => CircularLoader(),
          loaded: (loaded) {
            if (loaded.cafes.length == 0) {
              return NoData();
            }
            return CafeList(state: loaded);
          },
          failure: (failure) => FailureContainer(
            message: failure.message,
            onRefresh: () => context
                .bloc<CafeListBloc>()
                .add(Refresh(filter: failure.filter)),
          ),
          failureNoLocationPermission: (f) => NoLocationPermission(
            onPermissionGranted: () =>
                context.bloc<CafeListBloc>().add(Refresh(filter: f.filter)),
          ),
          failureNoLocationService: (f) => NoLocationService(
            onLocationServiceOpened: () =>
                context.bloc<CafeListBloc>().add(Refresh(filter: f.filter)),
          ),
        );
      },
    );
  }
}
