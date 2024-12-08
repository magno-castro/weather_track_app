import 'package:weather_track_app/features/weather/domain/entities/forecast_weather.dart';

import '../repositories/i_weather_repository.dart';

class GetForecastWeather {
  final IWeatherRepository repository;

  const GetForecastWeather({required this.repository});

  Stream<List<ForecastWeather>> call({required List<String> cities}) async* {
    yield* repository.forecastWeather(cities: cities);
  }
}
