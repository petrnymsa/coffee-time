import 'package:flutter/material.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Build ${this.toStringShort()}');
    return Center(
      child: Text('Favorites'),
    );
  }
}
