import 'package:bloc/bloc.dart';

import '../../../models/app_tab.dart';
import 'tab_event.dart';

class TabsBloc extends Bloc<TabEvent, AppTab> {
  @override
  AppTab get initialState => AppTab.cafeList;

  @override
  Stream<AppTab> mapEventToState(
    TabEvent event,
  ) async* {
    if (event is SetTab) {
      yield event.tab;
    }
  }
}
