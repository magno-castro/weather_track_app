import 'package:weather_track_app/core/error/failures.dart';
import 'package:weather_track_app/core/network/network_info.dart';
import 'package:weather_track_app/features/weather/data/datasources/local/i_weather_local_datasource.dart';

import '../../domain/entities/forecast_weather.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/i_weather_repository.dart';
import '../datasources/remote/i_weather_remote_datasource.dart';

class WeatherRepository implements IWeatherRepository {
  final INetworkInfo networkInfo;
  final IWeatherLocalDatasource localDatasource;
  final IWeatherRemoteDatasource remoteDatasource;

  const WeatherRepository({
    required this.networkInfo,
    required this.localDatasource,
    required this.remoteDatasource,
  });

  @override
  Stream<Weather> currentWeather({required String city}) async* {
    final cache = await localDatasource
        .currentWeather(city: city)
        .then((value) => value?.toEntity());

    if (cache != null) yield cache;

    if (await networkInfo.isConnected) {
      final response = await remoteDatasource.currentWeather(city: city);

      yield response.toEntity();

      await localDatasource.setCurrentWeather(city: city, data: response);
    } else {
      throw const NoConnectionFailure();
    }
  }

  @override
  Stream<List<ForecastWeather>> forecastWeather(
      {required List<String> cities}) async* {
    final cache = <ForecastWeather>[];

    for (var city in cities) {
      final result = await localDatasource.forecastWeather(city: city).then(
          (value) => value?.map((element) => element.toEntity()).toList());

      if (result != null) {
        cache.add(
            ForecastWeather(cityName: result.first.cityName, weathers: result));
      }
    }

    if (cache.isNotEmpty) yield cache;

    if (await networkInfo.isConnected) {
      final remote = <ForecastWeather>[];

      for (var city in cities) {
        final response = await remoteDatasource.forecastWeather(city: city);

        final weathers = response.map((element) => element.toEntity()).toList();

        remote.add(ForecastWeather(
            cityName: weathers.first.cityName, weathers: weathers));

        await localDatasource.setForecastWeather(city: city, data: response);
      }

      yield remote;
    } else {
      throw const NoConnectionFailure();
    }
  }
}
