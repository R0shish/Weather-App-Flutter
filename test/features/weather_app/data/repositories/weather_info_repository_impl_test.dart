import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/platform/network_info.dart';
import 'package:weather_app/features/weather_app/data/datasources/weather_info_local_data_source.dart';
import 'package:weather_app/features/weather_app/data/datasources/weather_info_remote_datasource.dart';
import 'package:weather_app/features/weather_app/data/models/weather_info_model.dart';
import 'package:weather_app/features/weather_app/data/repositories/weather_info_repository_impl.dart';
import 'package:weather_app/features/weather_app/domain/entities/weather_info.dart';
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

  const tCity = 'Kathmandu';
  const tWeatherInfoModel = WeatherInfoModel(
      main: 'Cloud',
      description: 'broken clouds',
      temp: 22.12,
      feelsLike: 22.69,
      tempMin: 22.12,
      tempMax: 22.12,
      pressure: 1012,
      humidity: 88,
      windSpeed: 2.06,
      windDeg: 80,
      cloudsAll: 75,
      country: 'NP',
      cityName: tCity,
      sunrise: 1663286658,
      sunset: 1663331005,
      cod: 200);
  const WeatherInfo tWeatherInfo = tWeatherInfoModel;
  test('should check if the device is online', () async {
    // arrange
    when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    // act
    repository.getWeatherInfo(tCity);
    // assert
    verify(mockNetworkInfo.isConnected);
  });

  group('device is online', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockWeatherInfoRemoteDataSource.getWeatherInfo(any))
          .thenAnswer((_) async => tWeatherInfoModel);
      // act
      final result = await repository.getWeatherInfo(tCity);
      // assert
      verify(mockWeatherInfoRemoteDataSource.getWeatherInfo(tCity));
      expect(result, equals(const Right(tWeatherInfo)));
    });

    test(
        'should cache the data locally when the call to remote data source is successful',
        () async {
      // arrange
      when(mockWeatherInfoRemoteDataSource.getWeatherInfo(any))
          .thenAnswer((_) async => tWeatherInfoModel);
      // act
      await repository.getWeatherInfo(tCity);
      // assert
      verify(mockWeatherInfoRemoteDataSource.getWeatherInfo(tCity));
      verify(
          mockWeatherInfoLocalDataSource.cacheWeatherInfo(tWeatherInfoModel));
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockWeatherInfoRemoteDataSource.getWeatherInfo(any))
          .thenThrow(ServerException('Server Error'));
      // act
      final result = await repository.getWeatherInfo(tCity);
      // assert
      verify(mockWeatherInfoRemoteDataSource.getWeatherInfo(tCity));
      verifyZeroInteractions(mockWeatherInfoLocalDataSource);
      expect(result, equals(Left(ServerFailure())));
    });
  });

  group('device is offline', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    });
    test(
        'should return last locally cached data when the cached data is present',
        () async {
      // arrange
      when(mockWeatherInfoLocalDataSource.getLastWeatherInfo())
          .thenAnswer((_) async => tWeatherInfoModel);
      // act
      final result = await repository.getWeatherInfo(tCity);
      // assert
      verifyZeroInteractions(mockWeatherInfoRemoteDataSource);
      verify(mockWeatherInfoLocalDataSource.getLastWeatherInfo());
      expect(result, equals(const Right(tWeatherInfo)));
    });

    test('should return CacheFailure when the cached data is not present',
        () async {
      // arrange
      when(mockWeatherInfoLocalDataSource.getLastWeatherInfo())
          .thenThrow(CacheException('Cache Error'));
      // act
      final result = await repository.getWeatherInfo(tCity);
      // assert
      verifyZeroInteractions(mockWeatherInfoRemoteDataSource);
      verify(mockWeatherInfoLocalDataSource.getLastWeatherInfo());
      expect(result, equals(Left(CacheFailure())));
    });
  });
}
