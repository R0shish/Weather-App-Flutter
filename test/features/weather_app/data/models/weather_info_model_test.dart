import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather_app/data/models/weather_info_model.dart';
import 'package:weather_app/features/weather_app/domain/entities/weather_info.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tWeatherInfoModel = WeatherInfoModel(
      main: 'Clouds',
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

  test(
    'should be a subclass of WeatherInfo entity',
    () async {
      // assert
      expect(tWeatherInfoModel, isA<WeatherInfo>());
    },
  );
  test(
    'should return a valid model when the JSON cod is 200',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(fixture('weather_info.json'));
      // act
      final result = WeatherInfoModel.fromJson(jsonMap);
      // assert
      expect(result, tWeatherInfoModel);
    },
  );

  test(
    'should return a JSON map containing proper data',
    () async {
      // act
      final result = tWeatherInfoModel.toJson();
      // assert
      final expectedMap = {
        'main': 'Clouds',
        'description': 'broken clouds',
        'temp': 22.12,
        'feels_like': 22.69,
        'temp_min': 22.12,
        'temp_max': 22.12,
        'pressure': 1012,
        'humidity': 88,
        'wind_speed': 2.06,
        'wind_deg': 80,
        'clouds_all': 75,
        'country': 'NP',
        'city_name': 'Kathmandu',
        'sunrise': 1663286658,
        'sunset': 1663331005,
        'cod': 200
      };
      expect(result, expectedMap);
    },
  );
}
