import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:weather_app/features/weather_app/domain/entities/weather_info.dart';
import 'package:weather_app/features/weather_app/domain/repositories/weather_info_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/weather_app/domain/usecases/get_weather_info.dart';

import 'get_weather_info_test.mocks.dart';

@GenerateMocks([WeatherInfoRepository])
void main() {
  const tCityName = 'Kathmandu';
  const tWeatherInfo = WeatherInfo(
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
  final mockWeatherInfoRepository = MockWeatherInfoRepository();
  final usecase = GetWeatherInfo(mockWeatherInfoRepository);
  test('should get weather info for the city from the repository', () async {
    // arrange
    when(mockWeatherInfoRepository.getWeatherInfo(any))
        .thenAnswer((_) async => const Right(tWeatherInfo));
    // act
    final result = await usecase(const Params(cityName: tCityName));
    // assert
    expect(result, const Right(tWeatherInfo));
    verify(mockWeatherInfoRepository.getWeatherInfo(tCityName));
    verifyNoMoreInteractions(mockWeatherInfoRepository);
  });
}
