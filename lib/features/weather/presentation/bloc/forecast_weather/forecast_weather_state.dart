part of 'forecast_weather_bloc.dart';

sealed class ForecastWeatherState extends Equatable {
  const ForecastWeatherState();

  @override
  List<Object> get props => [];
}

final class ForecastWeatherLoading extends ForecastWeatherState {}

final class ForecastWeatherLoaded extends ForecastWeatherState {
  final List<ForecastWeather> forecast;

  const ForecastWeatherLoaded({required this.forecast});

  @override
  List<Object> get props => [forecast];
}

final class ForecastWeatherWarning extends ForecastWeatherState {
  final String message;

  const ForecastWeatherWarning({required this.message});

  @override
  List<Object> get props => [message];
}

final class ForecastWeatherError extends ForecastWeatherState {
  final String message;

  const ForecastWeatherError({required this.message});

  @override
  List<Object> get props => [message];
}
