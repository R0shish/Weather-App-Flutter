import 'dart:convert';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/weather_app/data/datasources/weather_info_local_data_source.dart';
import 'package:weather_app/features/weather_app/data/models/weather_info_model.dart';
import '../../../../fixtures/fixture_reader.dart';
import 'weather_info_local_data_source_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  MockSharedPreferences mockSharedPreferences = MockSharedPreferences();
  WeatherInfoLocalDataSourceImpl dataSource =
      WeatherInfoLocalDataSourceImpl(sharedPreferences: mockSharedPreferences);

  group('getLastWeatherInfo', () {
    final tWeatherInfoModel = WeatherInfoModel.fromJson(
        json.decode(fixture('cached_weather_info.json')));
    test(
        'should return WeatherInfoModel from SharedPreferences when there is one in the cache',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any))
          .thenReturn(fixture('cached_weather_info.json'));
      // act
      final result = await dataSource.getLastWeatherInfo();
      // assert
      verify(mockSharedPreferences.getString(cachedWeatherInfo));
      expect(result, equals(tWeatherInfoModel));
    });

    test('should throw a CacheException when there is no cached value',
        () async {
      // arrange
      when(mockSharedPreferences.getString(any)).thenReturn(null);
      // act
      final call = dataSource.getLastWeatherInfo;
      // assert
      expect(() => call(), throwsA(isA<CacheException>()));
    });
  });

  group('cacheNumberTrivia', () {
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
        cityName: 'Kathmandu',
        sunrise: 1663286658,
        sunset: 1663331005,
        cod: 200);
    test('should call SharedPreferences to cache the data', () async {
      when(mockSharedPreferences.setString(any, any))
          .thenAnswer((_) async => true);
      // act
      dataSource.cacheWeatherInfo(tWeatherInfoModel);
      // assert
      final expectedJsonString = json.encode(tWeatherInfoModel.toJson());
      verify(mockSharedPreferences.setString(
          cachedWeatherInfo, expectedJsonString));
    });
  });
}
