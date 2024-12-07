import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../models/weather_model.dart';

import 'i_weather_local_datasource.dart';

class FssWeatherLocalDatasource implements IWeatherLocalDatasource {
  final FlutterSecureStorage storage;

  FssWeatherLocalDatasource({required this.storage});

  @override
  Future<WeatherModel?> currentWeather({required String city}) async {
    final cache = await storage.read(key: '${city}_current_weather');

    return cache != null ? WeatherModel.fromJson(jsonDecode(cache)) : null;
  }

  @override
  Future<List<WeatherModel>?> forecastWeather({required String city}) async {
    final cache = await storage.read(key: '${city}_forecast_weather');

    return cache != null
        ? List.from(jsonDecode(cache))
            .map((data) => WeatherModel.fromJson(data))
            .toList()
        : null;
  }

  @override
  Future<void> setCurrentWeather({
    required String city,
    required WeatherModel data,
  }) =>
      storage.write(
          key: '${city}_current_weather', value: jsonEncode(data.toJson()));

  @override
  Future<void> setForecastWeather(
          {required String city, required List<WeatherModel> data}) =>
      storage.write(
          key: '${city}_forecast_weather',
          value: jsonEncode(data.map((d) => d.toJson()).toList()));
}
