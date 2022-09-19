import 'dart:convert';

import 'package:weather_app/core/error/exceptions.dart';

import '../models/weather_info_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherInfoRemoteDataSource {
  /// Calls the https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<WeatherInfoModel> getWeatherInfo(String city);
}

class WeatherInfoRemoteDataSourceImpl implements WeatherInfoRemoteDataSource {
  final http.Client client;

  WeatherInfoRemoteDataSourceImpl({required this.client});

  @override
  Future<WeatherInfoModel> getWeatherInfo(String city) async {
    final response = await client.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=cdffaa4cc6491debc7c970bbae3e8d3d'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      return Future.value(WeatherInfoModel.fromJson(
          json.decode(response.body) as Map<String, dynamic>));
    } else {
      throw ServerException('Server Error');
    }
  }
}
