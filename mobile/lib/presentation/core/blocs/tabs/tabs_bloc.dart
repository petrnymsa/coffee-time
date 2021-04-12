import 'package:bloc/bloc.dart';

import '../../../models/app_tab.dart';
import 'tab_event.dart';

class TabsBloc extends Bloc<TabEvent, AppTabKey> {
  TabsBloc() : super(AppTabKey.cafeList);

  @override
  Stream<AppTabKey> mapEventToState(
    TabEvent event,
  ) async* {
    if (event is SetTab) {
      yield event.tab;
    }
  }
}
