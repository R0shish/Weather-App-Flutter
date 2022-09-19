import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'weather_info_event.dart';
part 'weather_info_state.dart';

class WeatherInfoBloc extends Bloc<WeatherInfoEvent, WeatherInfoState> {
  WeatherInfoBloc() : super(WeatherInfoInitial()) {
    on<WeatherInfoEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
