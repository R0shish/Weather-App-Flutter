part of 'weather_info_bloc.dart';

abstract class WeatherInfoState extends Equatable {
  const WeatherInfoState();

  @override
  List<Object> get props => [];
}

class WeatherInfoInitial extends WeatherInfoState {}

class WeatherInfoLoading extends WeatherInfoState {}

class WeatherInfoLoaded extends WeatherInfoState {
  final WeatherInfo weatherInfo;

  const WeatherInfoLoaded({required this.weatherInfo});

  @override
  List<Object> get props => [weatherInfo];
}

class WeatherInfoError extends WeatherInfoState {
  final String message;

  const WeatherInfoError({required this.message});

  @override
  List<Object> get props => [message];
}
