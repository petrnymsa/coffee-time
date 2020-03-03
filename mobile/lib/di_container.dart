import 'package:coffee_time/domain/repositories/tags_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

import 'core/http_client_factory.dart';
import 'data/repositories/cafe_repository.dart';
import 'data/repositories/tag_repository.dart';
import 'data/services/cafe_service.dart';
import 'data/services/favorite_service.dart';
import 'data/services/photo_service.dart';
import 'data/services/tag_service.dart';
import 'domain/repositories/cafe_repository.dart';
import 'domain/services/location_service.dart';
import 'presentation/core/blocs/cafe_list/cafelist_bloc.dart';
import 'presentation/core/blocs/tabs/bloc.dart';
import 'presentation/screens/detail/bloc/detail_bloc.dart';

final GetIt sl = GetIt.I;

void setupContainer() {
  // * BLoCs
  sl.registerLazySingleton(
    () => CafeListBloc(
      locationService: sl(),
      cafeRepository: sl(),
    ),
  );
  sl.registerFactory(() => TabsBloc());
  sl.registerFactoryParam(
    (cafe, _) =>
        DetailBloc(cafe: cafe, cafeListBloc: sl(), cafeRepository: sl()),
  );

  // * Services
  sl.registerLazySingleton<LocationService>(
      () => GeolocatorLocationService(geolocator: Geolocator()));
  sl.registerLazySingleton<FavoriteService>(() => FavoriteLocalService());
  sl.registerLazySingleton<PhotoService>(() => PhotoServiceImpl());
  sl.registerLazySingleton<TagService>(
      () => TagServiceImpl(clientFactory: sl()));
  sl.registerLazySingleton<CafeService>(
      () => CafeServiceImpl(clientFactory: sl()));

  // * Repositories
  sl.registerLazySingleton<CafeRepository>(
    () => CafeRepositoryImpl(
        cafeService: sl(),
        favoriteService: sl(),
        photoService: sl(),
        tagRepository: sl()),
  );
  sl.registerLazySingleton<TagRepository>(
    () => TagRepositoryImpl(tagService: sl()),
  );

  // * Others
  sl.registerLazySingleton<HttpClientFactory>(() => HttpClientFactoryImpl());
}
