import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_track_app/features/weather/domain/repositories/i_weather_repository.dart';
import 'package:weather_track_app/features/weather/domain/usecases/get_current_weather.dart';

import '../../../../fixtures/samples/weather_sample.dart';

class MockWeatherRepository extends Mock implements IWeatherRepository {}

void main() {
  late GetCurrentWeather getCurrentWeather;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeather = GetCurrentWeather(repository: mockWeatherRepository);
  });

  tearDown(() {
    reset(mockWeatherRepository);
  });

  group('Get current weather usecase =>', () {
    const cityName = 'São Luís';

    test('should return weather when repository call is successful', () async {
      when(() => mockWeatherRepository.currentWeather(city: cityName))
          .thenAnswer((_) async* {
        yield weatherSample;
      });

      final result = getCurrentWeather(city: cityName);

      await expectLater(result, emitsInOrder([weatherSample, emitsDone]));
      verify(() => mockWeatherRepository.currentWeather(city: cityName))
          .called(1);
      verifyNoMoreInteractions(mockWeatherRepository);
    });

    test('should throw an exception when repository throws an error', () async {
      when(() => mockWeatherRepository.currentWeather(city: cityName))
          .thenThrow(Exception('Failed to fetch weather'));

      final result = getCurrentWeather(city: cityName);

      await expectLater(
          result,
          emitsInOrder([
            emitsError(isA<Exception>()),
            emitsDone,
          ]));
      verify(() => mockWeatherRepository.currentWeather(city: cityName))
          .called(1);
      verifyNoMoreInteractions(mockWeatherRepository);
    });
  });
}
