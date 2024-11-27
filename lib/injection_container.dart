import 'core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'features/news/data/datasources/news_local_data_source.dart';
import 'features/news/data/datasources/news_remote_data_source.dart';
import 'features/news/data/repositories/news_repository_impl.dart';
import 'features/news/domain/repositories/news_repository.dart';
import 'features/news/domain/usecases/news_usecases.dart';
import 'features/news/presentation/bloc/news_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
// Domain: Usecases
  sl.registerLazySingleton(() => NewsUsecase(sl()));

// Repository
  sl.registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

// Data: Datasources
  sl.registerLazySingleton<NewsRemoteDataSource>(
      () => NewsRemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<NewsLocalDataSource>(
      () => NewsLocalDataSourceImpl(sharedPreferences: sl()));

// Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

// External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());

  // Presentation: Features News
  sl.registerFactory(() => NewsBloc(getNews: sl()));
}
