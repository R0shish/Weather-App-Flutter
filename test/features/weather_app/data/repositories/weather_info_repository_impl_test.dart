import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/platform/network_info.dart';
import 'package:weather_app/features/weather_app/data/datasources/weather_info_local_data_source.dart';
import 'package:weather_app/features/weather_app/data/datasources/weather_info_remote_datasource.dart';
import 'package:weather_app/features/weather_app/data/repositories/weather_info_repository_impl.dart';

import 'weather_info_repository_impl_test.mocks.dart';

@GenerateMocks(
    [WeatherInfoRemoteDataSource, WeatherInfoLocalDataSource, NetworkInfo])
void main() {
  final mockWeatherInfoLocalDataSource = MockWeatherInfoLocalDataSource();
  final mockWeatherInfoRemoteDataSource = MockWeatherInfoRemoteDataSource();
  final mockNetworkInfo = MockNetworkInfo();
  final WeatherInfoRepositoryImpl repository = WeatherInfoRepositoryImpl(
      localDataSource: mockWeatherInfoLocalDataSource,
      remoteDataSource: mockWeatherInfoRemoteDataSource,
      networkInfo: mockNetworkInfo);
}
