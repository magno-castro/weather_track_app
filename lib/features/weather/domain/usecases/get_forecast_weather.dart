import '../entities/weather.dart';
import '../repositories/i_weather_repository.dart';

class GetForecastWeather {
  final IWeatherRepository repository;

  const GetForecastWeather({required this.repository});

  Stream<List<Weather>> call({required String city}) async* {
    yield* repository.forecastWeather(city: city);
  }
}
