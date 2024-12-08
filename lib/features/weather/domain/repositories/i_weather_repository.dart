import 'package:weather_track_app/features/weather/domain/entities/weather.dart';

import '../entities/forecast_weather.dart';

abstract class IWeatherRepository {
  Stream<Weather> currentWeather({required String city});
  Stream<List<ForecastWeather>> forecastWeather({required List<String> cities});
}
