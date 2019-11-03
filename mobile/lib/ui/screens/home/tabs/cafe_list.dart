import 'package:coffee_time/data/cafe_repository.dart';
import 'package:coffee_time/models/cafe.dart';
import 'package:coffee_time/ui/widgets/cafe_tile.dart';
import 'package:flutter/material.dart';

class CafeListTab extends StatelessWidget {
  CafeListTab({Key key}) : super(key: key);

  final _cafeRepository =
      InMemoryCafeRepository(); // todo inject through provider / bloc

  @override
  Widget build(BuildContext context) {
    print('Build ${this.toStringShort()}');
    return FutureBuilder(
      future: _cafeRepository.get(),
      builder: (ctx, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('Not started');
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          case ConnectionState.done:
            if (snapshot.hasError) {
              return Text(
                '${snapshot.error}',
                style: TextStyle(color: Colors.red),
              );
            } else {
              final data = snapshot.data as List<Cafe>;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (_, i) => CafeTile(
                  cafe: data[i],
                ),
              );
            }
        }
      },
    );
  }
}
