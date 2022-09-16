import 'package:weather_app/features/weather_app/domain/entities/weather_info.dart';

class WeatherInfoModel extends WeatherInfo {
  const WeatherInfoModel({
    required String main,
    required String description,
    required double temp,
    required double feelsLike,
    required double tempMin,
    required double tempMax,
    required int pressure,
    required int humidity,
    required double windSpeed,
    required int windDeg,
    required int cloudsAll,
    required String country,
    required String cityName,
    required int sunrise,
    required int sunset,
    required int cod,
  }) : super(
            main: main,
            description: description,
            temp: temp,
            feelsLike: feelsLike,
            tempMin: tempMin,
            tempMax: tempMax,
            pressure: pressure,
            humidity: humidity,
            windSpeed: windSpeed,
            windDeg: windDeg,
            cloudsAll: cloudsAll,
            country: country,
            cityName: cityName,
            sunrise: sunrise,
            sunset: sunset,
            cod: cod);

  factory WeatherInfoModel.fromJson(Map<String, dynamic> json) {
    return WeatherInfoModel(
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temp: json['main']['temp'],
      feelsLike: json['main']['feels_like'],
      tempMin: json['main']['temp_min'],
      tempMax: json['main']['temp_max'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'],
      windDeg: json['wind']['deg'],
      cloudsAll: json['clouds']['all'],
      country: json['sys']['country'],
      cityName: json['name'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      cod: json['cod'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'weather': [
        {
          'main': main,
          'description': description,
        }
      ],
      'main': {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
      },
      'wind': {
        'speed': windSpeed,
        'deg': windDeg,
      },
      'clouds': {
        'all': cloudsAll,
      },
      'sys': {
        'country': country,
        'sunrise': sunrise,
        'sunset': sunset,
      },
      'name': cityName,
      'cod': cod,
    };
  }
}
