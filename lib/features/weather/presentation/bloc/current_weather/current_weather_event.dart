part of 'current_weather_bloc.dart';

sealed class CurrentWeatherEvent extends Equatable {
  const CurrentWeatherEvent();

  @override
  List<Object> get props => [];
}

final class LoadCurrentWeatherEvent extends CurrentWeatherEvent {
  const LoadCurrentWeatherEvent();
}
