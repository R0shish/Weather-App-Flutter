// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/weather_app/domain/entities/weather_info.dart';
import 'package:weather_app/features/weather_app/domain/usecases/get_weather_info.dart';

part 'weather_info_event.dart';
part 'weather_info_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';

class WeatherInfoBloc extends Bloc<WeatherInfoEvent, WeatherInfoState> {
  final GetWeatherInfo getWeatherInfo;

  WeatherInfoBloc({
    required this.getWeatherInfo,
  }) : super(WeatherInfoInitial()) {
    on<WeatherInfoEvent>((event, emit) async {
      if (event is GetSearchedWeatherInfo) {
        emit(WeatherInfoLoading());
        final failureOrWeatherInfo =
            await getWeatherInfo(Params(cityName: event.city));
        emit(failureOrWeatherInfo.fold(
          (failure) => WeatherInfoError(message: _mapFailureToMessage(failure)),
          (weatherInfo) => WeatherInfoLoaded(weatherInfo: weatherInfo),
        ));
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return 'Unexpected Error';
    }
  }
}
