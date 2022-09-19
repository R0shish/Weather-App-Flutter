part of 'weather_info_bloc.dart';

abstract class WeatherInfoEvent extends Equatable {
  const WeatherInfoEvent();

  @override
  List<Object> get props => [];
}

class GetWeatherInfo extends WeatherInfoEvent {
  final String city;

  const GetWeatherInfo({required this.city});

  @override
  List<Object> get props => [city];
}
