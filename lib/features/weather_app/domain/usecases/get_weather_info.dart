import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/core/usecases/usecase.dart';
import 'package:weather_app/features/weather_app/domain/entities/weather_info.dart';
import 'package:weather_app/features/weather_app/domain/repositories/weather_info_repository.dart';

class GetWeatherInfo implements UseCase<WeatherInfo, Params> {
  final WeatherInfoRepository repository;

  GetWeatherInfo(this.repository);

  @override
  Future<Either<Failure, WeatherInfo>> call(Params params) async {
    return await repository.getWeatherInfo(params.cityName);
  }
}

class Params extends Equatable {
  final String cityName;
  const Params({required this.cityName});

  @override
  List<Object?> get props => [cityName];
}
