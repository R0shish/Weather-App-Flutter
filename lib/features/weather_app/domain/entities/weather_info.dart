import 'package:equatable/equatable.dart';

class WeatherInfo extends Equatable {
  final String main;
  final String description;
  final double temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int humidity;
  final double windSpeed;
  final int windDeg;
  final int cloudsAll;
  final String country;
  final String cityName;
  final int sunrise;
  final int sunset;
  final int cod;

  const WeatherInfo({
    required this.main,
    required this.description,
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
    required this.windSpeed,
    required this.windDeg,
    required this.cloudsAll,
    required this.country,
    required this.cityName,
    required this.sunrise,
    required this.sunset,
    required this.cod,
  });

  @override
  List<Object> get props => [
        main,
        description,
        temp,
        feelsLike,
        tempMin,
        tempMax,
        pressure,
        humidity,
        windSpeed,
        windDeg,
        cloudsAll,
        country,
        cityName,
        sunrise,
        sunset,
        cod,
      ];
}
