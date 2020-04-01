import 'package:geolocator/geolocator.dart';
import 'package:get_it/get_it.dart';

import 'core/app_config.dart';
import 'core/firebase/authentication.dart';
import 'core/http_client_factory.dart';
import 'core/time_provider.dart';
import 'data/repositories/cafe_repository.dart';
import 'data/repositories/tag_repository.dart';
import 'data/services/cached_tag_service.dart';
import 'data/services/cafe_service.dart';
import 'data/services/favorite_service.dart';
import 'data/services/photo_service.dart';
import 'data/services/tag_service.dart';
import 'domain/entities/cafe.dart';
import 'domain/repositories/cafe_repository.dart';
import 'domain/repositories/tags_repository.dart';
import 'domain/services/app_permission_provider.dart';
import 'domain/services/location_service.dart';
import 'presentation/core/blocs/favorites/favorites_bloc.dart';
import 'presentation/core/blocs/filter/bloc.dart';
import 'presentation/core/blocs/tabs/bloc.dart';
import 'presentation/screens/cafe_list/bloc/cafelist_bloc.dart';
import 'presentation/screens/detail/bloc/detail_bloc.dart';
import 'presentation/screens/map/bloc/map_bloc.dart';

final GetIt sl = GetIt.I;

Future<void> setupContainer(AppConfig appConfig) async {
  // * BLoCs
  sl.registerLazySingleton<CafeListBloc>(
    () => CafeListBloc(
      locationService: sl(),
      cafeRepository: sl(),
      favoritesBloc: sl(),
    ),
  );
  sl.registerFactory<TabsBloc>(() => TabsBloc());
  sl.registerFactory<FilterBloc>(() => FilterBloc(tagRepository: sl()));
  sl.registerLazySingleton<FavoritesBloc>(
    () => FavoritesBloc(cafeRepository: sl()),
  );
  sl.registerLazySingleton<MapBloc>(
    () => MapBloc(cafeRepository: sl(), locationService: sl()),
  );
  sl.registerFactoryParam<DetailBloc, Cafe, dynamic>(
    (cafe, _) => DetailBloc(
      cafe: cafe,
      cafeListBloc: sl(),
      cafeRepository: sl(),
      favoritesBloc: sl(),
    ),
  );

  // * Services
  sl.registerLazySingleton<AppPermissionProvider>(
      () => LocationAppPermissionProvider());
  sl.registerLazySingleton<LocationService>(() => GeolocatorLocationService(
      geolocator: Geolocator(), permissionProvider: sl()));
  sl.registerLazySingleton<FavoriteService>(() => FavoriteLocalService());
  sl.registerLazySingleton<PhotoService>(
      () => PhotoServiceImpl(appConfig: appConfig));
  sl.registerLazySingleton<TagService>(
    () => CachedTagService(
        tagService: TagServiceImpl(
            clientFactory: sl(), appConfig: appConfig, authProvider: sl()),
        timeProvider: sl()),
  );
  sl.registerLazySingleton<CafeService>(() => CafeServiceImpl(
      clientFactory: sl(), appConfig: appConfig, authProvider: sl()));

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

  // * Mock Repositories
  // sl.registerLazySingleton<CafeRepository>(() => MockedCafeRepository());
  // sl.registerLazySingleton<TagRepository>(() => MockedTagRepository());

  // * Others
  sl.registerLazySingleton<HttpClientFactory>(() => HttpClientFactoryImpl());
  sl.registerLazySingleton<TimeProvider>(() => TimeProvider());
  sl.registerLazySingleton<AppConfig>(() => appConfig);
  sl.registerLazySingleton<FirebaseAuthProvider>(() => FirebaseAuthProvider());
}
