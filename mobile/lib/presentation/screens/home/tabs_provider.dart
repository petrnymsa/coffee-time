import 'package:flutter/foundation.dart';

enum CurrentTab { CafeList, Map, Favorites, Settings }

//todo refactor TabsProvider
class TabsProvider with ChangeNotifier {
  CurrentTab _tab;

  CurrentTab get currentTab => _tab;

  TabsProvider() {
    _tab = CurrentTab.CafeList;
  }

  void changeTab(CurrentTab tab) {
    _tab = tab;
    notifyListeners();
  }
}
