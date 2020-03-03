import 'package:bloc/bloc.dart';

import '../../../models/app_tab.dart';
import 'tab_event.dart';

class TabsBloc extends Bloc<TabEvent, AppTabKey> {
  @override
  AppTabKey get initialState => AppTabKey.cafeList;

  @override
  Stream<AppTabKey> mapEventToState(
    TabEvent event,
  ) async* {
    if (event is SetTab) {
      yield event.tab;
    }
  }
}
