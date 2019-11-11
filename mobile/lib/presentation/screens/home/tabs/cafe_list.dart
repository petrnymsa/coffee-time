import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/domain/repository/cafe_repository.dart';
import 'package:coffee_time/presentation/screens/detail/detail.dart';
import 'package:coffee_time/ui/widgets/cafe_tile.dart';
import 'package:flutter/material.dart';

class CafeListTab extends StatelessWidget {
  CafeListTab({Key key}) : super(key: key);

  final _cafeRepository =
      InMemoryCafeRepository(); // todo inject through provider / bloc
  //todo refactor this
  @override
  Widget build(BuildContext context) {
    print('Build ${this.toStringShort()}');
    return FutureBuilder(
      future: _cafeRepository.getByLocation(null), //todo rewrite
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
              final data = snapshot.data as List<CafeEntity>;
              return _buildCafeList(context, data);
            }
        }
      },
    );
  }

  //todo refactor to standalone widget
  Widget _buildCafeList(BuildContext context, List<CafeEntity> data) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) => Hero(
              tag: data[i].id,
              child: CafeTile(
                cafe: data[i],
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    //todo push named route
                    builder: (_) => DetailScreen(cafe: data[i]),
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
