import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:weather_track_app/core/network/network_info.dart';
import 'package:weather_track_app/features/weather/data/datasources/local/i_weather_local_datasource.dart';
import 'package:weather_track_app/features/weather/data/datasources/remote/http_weather_remote_datasource.dart';
import 'package:weather_track_app/features/weather/data/datasources/remote/i_weather_remote_datasource.dart';
import 'package:weather_track_app/features/weather/data/repositories/weather_repository.dart';
import 'package:weather_track_app/features/weather/domain/repositories/i_weather_repository.dart';
import 'package:weather_track_app/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weather_track_app/features/weather/domain/usecases/get_forecast_weather.dart';
import 'package:weather_track_app/features/weather/presentation/bloc/current_weather/current_weather_bloc.dart';
import 'package:weather_track_app/features/weather/presentation/bloc/forecast_weather/forecast_weather_bloc.dart';

import '../features/weather/data/datasources/local/fss_weather_local_datasource.dart';

final di = GetIt.instance;

void init() {
  di.registerLazySingleton<IWeatherLocalDatasource>(
      () => const FssWeatherLocalDatasource(storage: FlutterSecureStorage()));
  di.registerLazySingleton<IWeatherRemoteDatasource>(() =>
      HttpWeatherRemoteDatasource(
          client: http.Client(),
          apiKey: const String.fromEnvironment('API_KEY')));
  di.registerLazySingleton<INetworkInfo>(
      () => NetworkInfo(connection: InternetConnection()));
  di.registerLazySingleton<IWeatherRepository>(() => WeatherRepository(
      networkInfo: di(), localDatasource: di(), remoteDatasource: di()));
  di.registerLazySingleton<GetCurrentWeather>(
      () => GetCurrentWeather(repository: di()));
  di.registerLazySingleton<GetForecastWeather>(
      () => GetForecastWeather(repository: di()));
  di.registerFactory<CurrentWeatherBloc>(
      () => CurrentWeatherBloc(getCurrentWeather: di()));
  di.registerFactory<ForecastWeatherBloc>(
      () => ForecastWeatherBloc(getForecastWeather: di()));
}
