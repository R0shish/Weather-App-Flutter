import 'dart:convert';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/error/exceptions.dart';
import 'package:weather_app/features/weather_app/data/datasources/weather_info_remote_datasource.dart';
import 'package:weather_app/features/weather_app/data/models/weather_info_model.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';
import 'weather_info_remote_data_source_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  MockClient mockHttpClient = MockClient();
  WeatherInfoRemoteDataSourceImpl dataSource =
      WeatherInfoRemoteDataSourceImpl(client: mockHttpClient);

  void setUpMockHttpClientSuccess200() {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
        (_) async => http.Response(fixture('weather_info.json'), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  const tCity = 'Kathmandu';
  final tWeatherInfoModel = WeatherInfoModel.fromJson(
      json.decode(fixture('weather_info.json')) as Map<String, dynamic>);
  test('''should perform a GET request on a URL with 
      city in the endpoint and with application/json header''', () {
    // arrange
    setUpMockHttpClientSuccess200();
    // act
    dataSource.getWeatherInfo(tCity);
    // assert
    verify(mockHttpClient.get(
      Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$tCity&appid=cdffaa4cc6491debc7c970bbae3e8d3d'),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
  });
  test('should return WeatherInfo when success code is 200 (success)',
      () async {
    // arange
    setUpMockHttpClientSuccess200();
    // act
    final result = await dataSource.getWeatherInfo(tCity);
    // assert
    expect(result, equals(tWeatherInfoModel));
  });

  test('should throw ServerException when response code is not 200', () async {
    // arange
    setUpMockHttpClientFailure404();
    // act
    final call = dataSource.getWeatherInfo;
    // assert
    expect(() => call(tCity), throwsA(isA<ServerException>()));
  });
}
