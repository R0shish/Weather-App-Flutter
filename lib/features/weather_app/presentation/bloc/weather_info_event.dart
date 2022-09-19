part of 'weather_info_bloc.dart';

abstract class WeatherInfoEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSearchedWeatherInfo extends WeatherInfoEvent {
  final String city;

  GetSearchedWeatherInfo({required this.city});

  @override
  List<Object> get props => [city];
}
