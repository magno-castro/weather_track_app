import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_track_app/core/error/failures.dart';
import 'package:weather_track_app/features/weather/domain/entities/forecast_weather.dart';
import 'package:weather_track_app/features/weather/domain/usecases/get_forecast_weather.dart';

part 'forecast_weather_event.dart';
part 'forecast_weather_state.dart';

class ForecastWeatherBloc
    extends Bloc<ForecastWeatherEvent, ForecastWeatherState> {
  final GetForecastWeather getForecastWeather;

  @visibleForTesting
  final cities = [
    'Silverstone, UK',
    'São Paulo, Brazil',
    'Melbourne, Australia',
    'Monte Carlo, Monaco',
  ];

  ForecastWeatherBloc({required this.getForecastWeather})
      : super(ForecastWeatherLoading()) {
    on<LoadForecastWeatherEvent>((event, emit) async {
      try {
        if (state is! ForecastWeatherLoading) {
          emit(ForecastWeatherLoading());
        }

        await for (var weather in getForecastWeather(cities: cities)) {
          emit(ForecastWeatherLoaded(forecast: weather));
        }
      } on NoConnectionFailure {
        const message = 'You are not connected to the internet';

        if (state is ForecastWeatherLoaded) {
          emit(const ForecastWeatherWarning(message: message));
        } else {
          emit(const ForecastWeatherError(message: message));
        }
      } on WeatherFailure catch (e) {
        emit(ForecastWeatherError(message: e.message));
      } catch (e) {
        emit(const ForecastWeatherError(
            message:
                'Sorry, an unknown error has occurred, please contact support'));
      }
    });
  }
}
