import 'package:dartz/dartz.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/weather_app/domain/entities/weather_info.dart';

abstract class WeatherInfoRepository {
  Future<Either<Failure, WeatherInfo>> getWeatherInfo(String city);
}
