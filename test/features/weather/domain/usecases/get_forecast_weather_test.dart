import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_track_app/features/weather/domain/repositories/i_weather_repository.dart';
import 'package:weather_track_app/features/weather/domain/usecases/get_forecast_weather.dart';

import '../../../../fixtures/samples/weather_sample.dart';

class MockWeatherRepository extends Mock implements IWeatherRepository {}

void main() {
  late GetForecastWeather getForecastWeather;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getForecastWeather = GetForecastWeather(repository: mockWeatherRepository);
  });

  tearDown(() {
    reset(mockWeatherRepository);
  });

  group('Get forecast weather usecase =>', () {
    const cityName = 'São Luís';

    test('should return a list of weather when repository call is successful',
        () async {
      when(() => mockWeatherRepository.forecastWeather(cities: [cityName]))
          .thenAnswer((_) async* {
        yield [forecastWeatherSample];
      });

      final result = getForecastWeather(cities: [cityName]);

      await expectLater(
          result,
          emitsInOrder([
            [forecastWeatherSample],
            emitsDone
          ]));
      verify(() => mockWeatherRepository.forecastWeather(cities: [cityName]))
          .called(1);
      verifyNoMoreInteractions(mockWeatherRepository);
    });

    test('should throw an exception when repository throws an error', () async {
      when(() => mockWeatherRepository.forecastWeather(cities: [cityName]))
          .thenThrow(Exception('Failed to fetch forecast'));

      final result = getForecastWeather(cities: [cityName]);

      await expectLater(
          result, emitsInOrder([emitsError(isA<Exception>()), emitsDone]));
      verify(() => mockWeatherRepository.forecastWeather(cities: [cityName]))
          .called(1);
      verifyNoMoreInteractions(mockWeatherRepository);
    });
  });
}
