// just some made up ideas
//todo layout helper (see ) - see https://www.youtube.com/watch?v=z7P1OFLw4kY
//todo add logger
//todo life cycle manager

import 'package:coffee_time/core/http_client_factory.dart';
import 'package:coffee_time/data/repositories/cafe_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

import '../data/repositories/tag_repository.dart';
import '../data/services/cafe_service.dart';
import '../data/services/favorite_service.dart';
import '../data/services/photo_service.dart';
import '../data/services/tag_service.dart';
import '../domain/entities/cafe.dart';
import '../domain/entities/location.dart';
import '../domain/services/location_service.dart';
import 'core/blocs/cafe_list/bloc.dart';
import 'core/blocs/tabs/bloc.dart';
import 'shared/theme.dart';
import 'shell.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Time',
      theme: AppTheme.apply(context),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CafeListBloc(
              cafeRepository: CafeRepositoryImpl(
                cafeService:
                    CafeServiceImpl(clientFactory: HttpClientFactoryImpl()),
                favoriteService: FavoriteLocalService(),
                photoService: PhotoServiceImpl(),
                tagRepository: TagRepositoryImpl(
                    tagService:
                        TagServiceImpl(clientFactory: HttpClientFactoryImpl())),
              ),
              locationService:
                  GeolocatorLocationService(geolocator: Geolocator()),
            )..add(Refresh()),
          ),
          BlocProvider(
            create: (_) => TabsBloc(),
          ),
        ],
        child: Shell(),
      ),
    );
  }
}

class Foo extends StatelessWidget {
  final Client client = Client();

  Foo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CafeListBloc, CafeListState>(
        builder: (context, state) {
          return state.when(
            loading: () => _buildLoading(context),
            loaded: (cafes, token) => _buildLoaded(context, cafes),
            failure: (failure) => _buildFailure(context, failure),
          );
        },
        // builder: (_, snapshot) {
        //   if (snapshot.hasError) return Text(snapshot.error.toString());

        //   if (snapshot.hasData) return Text(snapshot.data.toString());

        //   return CircularProgressIndicator();
        // },
      ),
    );
  }

  Widget _buildFailure(BuildContext context, String failure) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(FontAwesomeIcons.exclamationCircle),
        Text(failure)
      ],
    );
  }

  Widget _buildLoaded(BuildContext context, List<Cafe> cafes) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: cafes.length,
        itemBuilder: (_, i) => Text(cafes[i].name),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        RaisedButton(
          child: Text('Load'),
          onPressed: () => context
              .bloc<CafeListBloc>()
              .add(LoadNearby(Location(50.3561972222, 15.9213638889))),
        )
      ],
    );
  }
}
