import 'package:flutter/material.dart';

import '../../generated/i18n.dart';

extension ContextExtension on BuildContext {
  void showFavoriteChangedSnackBar({@required bool isFavorite}) {
    assert(isFavorite != null);

    final tr = I18n.of(this);
    final text = !isFavorite
        ? tr.notification_favoriteAdded
        : tr.notification_favoriteRemoved;

    showNotifcationSnackBar(text: text);
  }

  void showNotifcationSnackBar({@required String text}) {
    Scaffold.of(this).showSnackBar(SnackBar(
      backgroundColor: Theme.of(this).accentColor,
      content: Text(text),
      duration: const Duration(seconds: 1),
    ));
  }
}
