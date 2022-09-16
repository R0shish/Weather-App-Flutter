import 'package:weather_app/core/platform/network_info.dart';
import 'package:weather_app/features/weather_app/data/datasources/weather_info_local_data_source.dart';
import 'package:weather_app/features/weather_app/data/datasources/weather_info_remote_datasource.dart';
import 'package:weather_app/features/weather_app/domain/entities/weather_info.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:weather_app/features/weather_app/domain/repositories/weather_info_repository.dart';

class WeatherInfoRepositoryImpl implements WeatherInfoRepository {
  final WeatherInfoRemoteDataSource remoteDataSource;
  final WeatherInfoLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WeatherInfoRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WeatherInfo>> getWeatherInfo(String city) {
    // TODO: implement getWeatherInfo
    throw UnimplementedError();
  }
}
