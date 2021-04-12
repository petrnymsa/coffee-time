import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './bloc/bloc.dart';
import '../../shared/shared_widgets.dart';
import 'widgets/widgets.dart';

class CafeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CafeListBloc, CafeListState>(
      builder: (context, state) {
        return state.map(
          loading: (_) => const CircularLoader(),
          loaded: (loaded) {
            if (loaded.cafes.isEmpty) {
              return const NoData();
            }
            return CafeList(state: loaded);
          },
          failure: (failure) => FailureContainer(
            message: failure.message,
            onRefresh: () => context
                .read<CafeListBloc>()
                .add(Refresh(filter: failure.filter)),
          ),
          failureNoLocationPermission: (f) => NoLocationPermission(
            onPermissionGranted: () =>
                context.read<CafeListBloc>().add(Refresh(filter: f.filter)),
          ),
          failureNoLocationService: (f) => NoLocationService(
            onLocationServiceOpened: () =>
                context.read<CafeListBloc>().add(Refresh(filter: f.filter)),
          ),
        );
      },
    );
  }
}
