part of 'current_weather_bloc.dart';

sealed class CurrentWeatherState extends Equatable {
  const CurrentWeatherState();

  @override
  List<Object> get props => [];
}

final class CurrentWeatherLoading extends CurrentWeatherState {}

final class CurrentWeatherLoaded extends CurrentWeatherState {
  final Weather weather;

  const CurrentWeatherLoaded({required this.weather});

  @override
  List<Object> get props => [weather];
}

final class CurrentWeatherWarning extends CurrentWeatherState {
  final String message;

  const CurrentWeatherWarning({required this.message});

  @override
  List<Object> get props => [message];
}

final class CurrentWeatherError extends CurrentWeatherState {
  final String message;

  const CurrentWeatherError({required this.message});

  @override
  List<Object> get props => [message];
}
