import 'package:weather_track_app/features/weather/domain/entities/weather.dart';

abstract class IWeatherRepository {
  Stream<Weather> currentWeather({required String city});
  Stream<List<Weather>> forecastWeather({required String city});
}
