import '../entities/weather.dart';
import '../repositories/i_weather_repository.dart';

class GetCurrentWeather {
  final IWeatherRepository repository;

  const GetCurrentWeather({required this.repository});

  Stream<Weather> call({required String city}) async* {
    yield* repository.currentWeather(city: city);
  }
}
