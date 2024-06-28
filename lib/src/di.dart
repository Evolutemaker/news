import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:news/src/data/datasources/news_remote_data_source.dart';
import 'package:news/src/data/repositories/news_repository_impl.dart';
import 'package:news/src/domain/repositories/news_repository.dart';
import 'package:news/src/domain/usecases/get_news.dart';
import 'package:news/src/presentation/bloc/news_bloc/news_bloc.dart';
import 'package:news/src/utils/shared_preferences_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerLazySingleton(() => SharedPreferencesUtils());

  // Dio
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio();
    return dio;
  });

  // Logger
  getIt.registerLazySingleton(() => Logger(printer: PrettyPrinter()));

  // Data sources
  // getIt.registerLazySingleton(() => NewsRemoteDataSource(getIt()));
  getIt.registerLazySingleton(() => NewsRemoteDataSource(getIt(), getIt()));

  // Repositories
  getIt
      .registerLazySingleton<NewsRepository>(() => NewsRepositoryImpl(getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetNews(getIt()));

  // BLoC
  getIt.registerFactory(() => NewsBloc(
        getNews: getIt(),
        sharedPreferencesUtils: getIt(),
      ));
}