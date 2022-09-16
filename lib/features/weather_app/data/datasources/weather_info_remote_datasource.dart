import '../models/weather_info_model.dart';

abstract class WeatherInfoRemoteDataSource {
  /// Calls the https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherInfoModel> getWeatherInfo(String city);
}
