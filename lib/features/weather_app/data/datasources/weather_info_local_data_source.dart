import 'package:weather_app/features/weather_app/data/models/weather_info_model.dart';

abstract class WeatherInfoLocalDataSource {
  /// Gets the cached [WeatherInfoModel] which was retrieved
  /// the last time the user had an internet connection.
  ///
  /// Throws [CacheException] if no cached data is present.
  Future<WeatherInfoModel> getLastWeatherInfo();

  Future<void> cacheWeatherInfo(WeatherInfoModel weatherInfoToCache);
}
