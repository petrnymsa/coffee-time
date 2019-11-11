import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:coffee_time/domain/entities/cafe.dart';
import 'package:coffee_time/presentation/core/base_provider.dart';
import 'package:coffee_time/presentation/models/cafe.dart';
import 'package:coffee_time/presentation/screens/detail/detail.dart';
import 'package:coffee_time/presentation/screens/home/home_provider.dart';
import 'package:coffee_time/presentation/widgets/cafe_tile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CafeListTab extends StatelessWidget {
  CafeListTab({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('Build ${this.toStringShort()}');
    return Consumer<HomeProvider>(
      builder: (ctx, model, child) {
        if (model.state == ProviderState.busy)
          return Center(
            child: CircularProgressIndicator(),
          );

        return _buildCafeList(ctx, model.cafes);
      },
    );
  }

  //todo refactor to standalone widget
  Widget _buildCafeList(BuildContext context, List<Cafe> data) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (_, i) => Hero(
              tag: data[i].entity.id,
              child: CafeTile(
                cafe: data[i].entity,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    //todo push named route
                    builder: (_) => DetailScreen(cafe: data[i].entity),
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
