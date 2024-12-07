import 'package:weather_track_app/features/weather/data/models/weather_model.dart';

abstract class IWeatherRemoteDatasource {
  Future<WeatherModel> currentWeather({required String city});
  Future<List<WeatherModel>> forecastWeather({required String city});
}
