import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/weather_app/data/models/weather_info_model.dart';

abstract class WeatherInfoLocalDataSource {
  /// Gets the cached [WeatherInfoModel] which was retrieved
  /// the last time the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<WeatherInfoModel> getLastWeatherInfo();

  Future<void> cacheWeatherInfo(WeatherInfoModel weatherInfoToCache);
}

const cachedWeatherInfo = 'CACHED_WEATHER_INFO';

class WeatherInfoLocalDataSourceImpl implements WeatherInfoLocalDataSource {
  final SharedPreferences sharedPreferences;

  WeatherInfoLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<WeatherInfoModel> getLastWeatherInfo() {
    final jsonString = sharedPreferences.getString(cachedWeatherInfo);
    if (jsonString != null) {
      return Future.value(WeatherInfoModel.fromJson(json.decode(jsonString)));
    } else {
      throw CacheException('Cache Error');
    }
  }

  @override
  Future<void> cacheWeatherInfo(WeatherInfoModel weatherInfoToCache) {
    return sharedPreferences.setString(
      cachedWeatherInfo,
      json.encode(weatherInfoToCache.toJson()),
    );
  }
}
