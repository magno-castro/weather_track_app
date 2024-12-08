import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_track_app/core/error/failures.dart';
import 'package:weather_track_app/features/weather/domain/usecases/get_forecast_weather.dart';
import 'package:weather_track_app/features/weather/presentation/bloc/forecast_weather/forecast_weather_bloc.dart';

import '../../../../../fixtures/samples/weather_sample.dart';

class MockGetForecastWeather extends Mock implements GetForecastWeather {}

void main() {
  late MockGetForecastWeather mockGetForecastWeather;
  late ForecastWeatherBloc weatherBloc;

  setUp(() {
    mockGetForecastWeather = MockGetForecastWeather();
    weatherBloc =
        ForecastWeatherBloc(getForecastWeather: mockGetForecastWeather);
  });

  tearDown(() {
    weatherBloc.close();
    reset(mockGetForecastWeather);
  });

  group('Forecast weather BLoC =>', () {
    test('should emit loaded state when weather is successfully loaded',
        () async {
      when(() => mockGetForecastWeather(cities: weatherBloc.cities))
          .thenAnswer((_) async* {
        yield [forecastWeatherSample];
      });

      weatherBloc
        ..add(const LoadForecastWeatherEvent())
        ..close();

      await expectLater(
          weatherBloc.stream,
          emitsInOrder([
            ForecastWeatherLoaded(forecast: [forecastWeatherSample]),
            emitsDone,
          ]));
      await untilCalled(
          () => mockGetForecastWeather(cities: weatherBloc.cities));
      verify(() => mockGetForecastWeather(cities: weatherBloc.cities))
          .called(1);
      verifyNoMoreInteractions(mockGetForecastWeather);
    });

    test(
        'should emit warning when there is no internet connection but has cache',
        () async {
      when(() => mockGetForecastWeather(cities: weatherBloc.cities))
          .thenAnswer((_) async* {
        yield [forecastWeatherSample];
        throw const NoConnectionFailure();
      });

      weatherBloc
        ..add(const LoadForecastWeatherEvent())
        ..close();

      expectLater(
          weatherBloc.stream,
          emitsInOrder([
            ForecastWeatherLoaded(forecast: [forecastWeatherSample]),
            const ForecastWeatherWarning(
                message: 'You are not connected to the internet'),
            emitsDone,
          ]));
      await untilCalled(
          () => mockGetForecastWeather(cities: weatherBloc.cities));
      verify(() => mockGetForecastWeather(cities: weatherBloc.cities))
          .called(1);
      verifyNoMoreInteractions(mockGetForecastWeather);
    });

    test('should emit error when there is no internet connection', () async {
      when(() => mockGetForecastWeather(cities: weatherBloc.cities))
          .thenAnswer((_) async* {
        throw const NoConnectionFailure();
      });

      weatherBloc
        ..add(const LoadForecastWeatherEvent())
        ..close();

      expectLater(
          weatherBloc.stream,
          emitsInOrder([
            const ForecastWeatherError(
                message: 'You are not connected to the internet'),
            emitsDone,
          ]));
      await untilCalled(
          () => mockGetForecastWeather(cities: weatherBloc.cities));
      verify(() => mockGetForecastWeather(cities: weatherBloc.cities))
          .called(1);
      verifyNoMoreInteractions(mockGetForecastWeather);
    });

    test('should emit error when a WeatherFailure occurs', () async {
      when(() => mockGetForecastWeather(cities: weatherBloc.cities))
          .thenAnswer((_) async* {
        throw const WeatherFailure(
            message: 'Failed to fetch weather data', error: 'code');
      });

      weatherBloc
        ..add(const LoadForecastWeatherEvent())
        ..close();

      expectLater(
          weatherBloc.stream,
          emitsInOrder([
            const ForecastWeatherError(message: 'Failed to fetch weather data'),
            emitsDone,
          ]));
      await untilCalled(
          () => mockGetForecastWeather(cities: weatherBloc.cities));
      verify(() => mockGetForecastWeather(cities: weatherBloc.cities))
          .called(1);
      verifyNoMoreInteractions(mockGetForecastWeather);
    });

    test('should emit error when an unknown error occurs', () async {
      when(() => mockGetForecastWeather(cities: weatherBloc.cities))
          .thenAnswer((_) async* {
        throw Exception();
      });

      weatherBloc
        ..add(const LoadForecastWeatherEvent())
        ..close();

      expectLater(
          weatherBloc.stream,
          emitsInOrder([
            const ForecastWeatherError(
                message:
                    'Sorry, an unknown error has occurred, please contact support'),
            emitsDone,
          ]));
      await untilCalled(
          () => mockGetForecastWeather(cities: weatherBloc.cities));
      verify(() => mockGetForecastWeather(cities: weatherBloc.cities))
          .called(1);
      verifyNoMoreInteractions(mockGetForecastWeather);
    });
  });
}
