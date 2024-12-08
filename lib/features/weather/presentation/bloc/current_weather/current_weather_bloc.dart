import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_track_app/core/error/failures.dart';
import 'package:weather_track_app/features/weather/domain/entities/weather.dart';

import '../../../domain/usecases/get_current_weather.dart';

part 'current_weather_event.dart';
part 'current_weather_state.dart';

class CurrentWeatherBloc
    extends Bloc<CurrentWeatherEvent, CurrentWeatherState> {
  final GetCurrentWeather getCurrentWeather;

  CurrentWeatherBloc({required this.getCurrentWeather})
      : super(CurrentWeatherLoading()) {
    on<LoadCurrentWeatherEvent>((event, emit) async {
      try {
        if (state is! CurrentWeatherLoading) {
          emit(CurrentWeatherLoading());
        }

        await for (var weather in getCurrentWeather(city: 'São Luís')) {
          emit(CurrentWeatherLoaded(weather: weather));
        }
      } on NoConnectionFailure {
        const message = 'You are not connected to the internet';

        if (state is CurrentWeatherLoaded) {
          emit(const CurrentWeatherWarning(message: message));
        } else {
          emit(const CurrentWeatherError(message: message));
        }
      } on WeatherFailure catch (e) {
        emit(CurrentWeatherError(message: e.message));
      } catch (e) {
        emit(const CurrentWeatherError(
            message:
                'Sorry, an unknown error has occurred, please contact support'));
      }
    });
  }
}
