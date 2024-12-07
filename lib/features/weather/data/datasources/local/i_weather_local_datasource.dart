import 'dart:async';

import 'package:weather_track_app/features/weather/data/models/weather_model.dart';

abstract class IWeatherLocalDatasource {
  Future<WeatherModel?> currentWeather({required String city});
  Future<void> setCurrentWeather({
    required String city,
    required WeatherModel data,
  });
  Future<List<WeatherModel>?> forecastWeather({required String city});
  Future<void> setForecastWeather({
    required String city,
    required List<WeatherModel> data,
  });
}
