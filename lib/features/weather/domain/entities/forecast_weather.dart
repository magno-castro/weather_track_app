import 'package:equatable/equatable.dart';
import 'package:weather_track_app/features/weather/domain/entities/weather.dart';

class ForecastWeather extends Equatable {
  final String cityName;
  final List<Weather> weathers;

  const ForecastWeather({
    required this.cityName,
    required this.weathers,
  });

  @override
  List<Object?> get props => [
        cityName,
        weathers,
      ];
}
