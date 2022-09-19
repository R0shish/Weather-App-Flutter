import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/weather_app/data/datasources/weather_info_local_data_source.dart';
import 'package:weather_app/features/weather_app/data/datasources/weather_info_remote_datasource.dart';
import 'package:weather_app/features/weather_app/data/repositories/weather_info_repository_impl.dart';
import 'package:weather_app/features/weather_app/domain/repositories/weather_info_repository.dart';
import 'package:weather_app/features/weather_app/domain/usecases/get_weather_info.dart';
import 'package:weather_app/features/weather_app/presentation/bloc/weather_info_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  ///  Features - Weather App
  // Bloc
  sl.registerFactory(() => WeatherInfoBloc(getWeatherInfo: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetWeatherInfo(sl()));

  // Repository
  sl.registerLazySingleton<WeatherInfoRepository>(
    () => WeatherInfoRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<WeatherInfoRemoteDataSource>(
    () => WeatherInfoRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<WeatherInfoLocalDataSource>(
    () => WeatherInfoLocalDataSourceImpl(sharedPreferences: sl()),
  );

  ///  Core
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  ///  External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client);
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
