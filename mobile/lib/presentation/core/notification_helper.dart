import 'package:flutter/material.dart';

import '../../generated/i18n.dart';

extension ContextExtension on BuildContext {
  void showFavoriteChangedSnackBar(
      {@required bool isFavorite,
      Duration duration = const Duration(seconds: 1),
      Function undoAction}) {
    assert(isFavorite != null);

    final tr = I18n.of(this);
    final text = !isFavorite
        ? tr.notification_favoriteAdded
        : tr.notification_favoriteRemoved;

    showNotificationSnackBar(
        text: text, duration: duration, undoCallBack: undoAction);
  }

  void showNotificationSnackBar({
    @required String text,
    Duration duration = const Duration(seconds: 1),
    Function undoCallBack,
  }) {
    Scaffold.of(this).showSnackBar(SnackBar(
      backgroundColor: Theme.of(this).accentColor,
      content: Text(text),
      duration: duration,
      action: undoCallBack != null
          ? SnackBarAction(
              textColor: Colors.white,
              label: 'Zpet',
              onPressed: undoCallBack,
            )
          : null,
    ));
  }

  void showNotificationWithLoadingSnackBar({
    @required String text,
    Duration duration = const Duration(seconds: 1),
  }) {
    Scaffold.of(this).showSnackBar(SnackBar(
      backgroundColor: Theme.of(this).accentColor,
      content: Row(
        children: [
          const CircularProgressIndicator(strokeWidth: 2),
          const SizedBox(width: 2),
          Text(text),
        ],
      ),
      duration: duration,
    ));
  }
}
