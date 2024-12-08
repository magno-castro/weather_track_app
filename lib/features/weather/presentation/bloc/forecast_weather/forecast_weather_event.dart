part of 'forecast_weather_bloc.dart';

sealed class ForecastWeatherEvent extends Equatable {
  const ForecastWeatherEvent();

  @override
  List<Object> get props => [];
}

final class LoadForecastWeatherEvent extends ForecastWeatherEvent {
  const LoadForecastWeatherEvent();
}
