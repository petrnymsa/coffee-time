import 'package:coffee_time/domain/entities/location.dart';
import 'package:coffee_time/presentation/providers/cafe_list.dart';
import 'package:coffee_time/presentation/screens/home/home.dart';
import 'package:coffee_time/presentation/services/location_service.dart';
import 'package:coffee_time/presentation/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// just some made up ideas
//todo layout helper (see ) - see https://www.youtube.com/watch?v=z7P1OFLw4kY
//todo add logger
//todo life cycle manager

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return ChangeNotifierProvider(
    //   create: (_) => CafeListProvider()..refresh(),
    //   child: MaterialApp(
    //     title: 'Flutter Demo',
    //     theme: AppTheme.apply(context),
    //     home: HomeScreen(),
    //   ),
    // );
    final service = GeolocatorLocationService();
    final stream = service.listen(distanceFilter: 100);

    return MaterialApp(
      home: Foo(stream: stream),
    );
  }
}

class Foo extends StatelessWidget {
  const Foo({
    Key key,
    @required this.stream,
  }) : super(key: key);

  final Stream<Location> stream;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: stream,
          builder: (_, snapshot) {
            if (snapshot.hasError) return Text(snapshot.error.toString());

            if (snapshot.hasData) return Text(snapshot.data.toString());

            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
