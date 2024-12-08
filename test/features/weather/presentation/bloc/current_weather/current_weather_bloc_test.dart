import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_track_app/core/error/failures.dart';
import 'package:weather_track_app/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weather_track_app/features/weather/presentation/bloc/current_weather/current_weather_bloc.dart';

import '../../../../../fixtures/samples/weather_sample.dart';

class MockGetCurrentWeather extends Mock implements GetCurrentWeather {}

void main() {
  late MockGetCurrentWeather mockGetCurrentWeather;
  late CurrentWeatherBloc weatherBloc;

  setUp(() {
    mockGetCurrentWeather = MockGetCurrentWeather();
    weatherBloc = CurrentWeatherBloc(getCurrentWeather: mockGetCurrentWeather);
  });

  tearDown(() {
    weatherBloc.close();
    reset(mockGetCurrentWeather);
  });

  group('Current weather BLoC =>', () {
    test('should emit loaded state when weather is successfully loaded',
        () async {
      when(() => mockGetCurrentWeather(city: 'São Luís'))
          .thenAnswer((_) async* {
        yield weatherSample;
      });

      weatherBloc
        ..add(const LoadCurrentWeatherEvent())
        ..close();

      await expectLater(
          weatherBloc.stream,
          emitsInOrder([
            CurrentWeatherLoaded(weather: weatherSample),
            emitsDone,
          ]));
      await untilCalled(() => mockGetCurrentWeather(city: 'São Luís'));
      verify(() => mockGetCurrentWeather(city: 'São Luís')).called(1);
      verifyNoMoreInteractions(mockGetCurrentWeather);
    });

    test(
        'should emit warning when there is no internet connection but has cache',
        () async {
      when(() => mockGetCurrentWeather(city: 'São Luís'))
          .thenAnswer((_) async* {
        yield weatherSample;
        throw const NoConnectionFailure();
      });

      weatherBloc
        ..add(const LoadCurrentWeatherEvent())
        ..close();

      expectLater(
          weatherBloc.stream,
          emitsInOrder([
            CurrentWeatherLoaded(weather: weatherSample),
            const CurrentWeatherWarning(
                message: 'You are not connected to the internet'),
            emitsDone,
          ]));
      await untilCalled(() => mockGetCurrentWeather(city: 'São Luís'));
      verify(() => mockGetCurrentWeather(city: 'São Luís')).called(1);
      verifyNoMoreInteractions(mockGetCurrentWeather);
    });

    test('should emit error when there is no internet connection', () async {
      when(() => mockGetCurrentWeather(city: 'São Luís'))
          .thenAnswer((_) async* {
        throw const NoConnectionFailure();
      });

      weatherBloc
        ..add(const LoadCurrentWeatherEvent())
        ..close();

      expectLater(
          weatherBloc.stream,
          emitsInOrder([
            const CurrentWeatherError(
                message: 'You are not connected to the internet'),
            emitsDone,
          ]));
      await untilCalled(() => mockGetCurrentWeather(city: 'São Luís'));
      verify(() => mockGetCurrentWeather(city: 'São Luís')).called(1);
      verifyNoMoreInteractions(mockGetCurrentWeather);
    });

    test('should emit error when a WeatherFailure occurs', () async {
      when(() => mockGetCurrentWeather(city: 'São Luís'))
          .thenAnswer((_) async* {
        throw const WeatherFailure(
            message: 'Failed to fetch weather data', error: 'code');
      });

      weatherBloc
        ..add(const LoadCurrentWeatherEvent())
        ..close();

      expectLater(
          weatherBloc.stream,
          emitsInOrder([
            const CurrentWeatherError(message: 'Failed to fetch weather data'),
            emitsDone,
          ]));
      await untilCalled(() => mockGetCurrentWeather(city: 'São Luís'));
      verify(() => mockGetCurrentWeather(city: 'São Luís')).called(1);
      verifyNoMoreInteractions(mockGetCurrentWeather);
    });

    test('should emit error when an unknown error occurs', () async {
      when(() => mockGetCurrentWeather(city: 'São Luís'))
          .thenAnswer((_) async* {
        throw Exception();
      });

      weatherBloc
        ..add(const LoadCurrentWeatherEvent())
        ..close();

      expectLater(
          weatherBloc.stream,
          emitsInOrder([
            const CurrentWeatherError(
                message:
                    'Sorry, an unknown error has occurred, please contact support'),
            emitsDone,
          ]));
      await untilCalled(() => mockGetCurrentWeather(city: 'São Luís'));
      verify(() => mockGetCurrentWeather(city: 'São Luís')).called(1);
      verifyNoMoreInteractions(mockGetCurrentWeather);
    });
  });
}
