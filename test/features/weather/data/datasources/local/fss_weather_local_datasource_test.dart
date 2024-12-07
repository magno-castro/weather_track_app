import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_track_app/features/weather/data/datasources/local/fss_weather_local_datasource.dart';
import 'package:weather_track_app/features/weather/data/datasources/local/i_weather_local_datasource.dart';

import '../../../../../fixtures/json/weather_json.dart';
import '../../../../../fixtures/samples/weather_model_sample.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late IWeatherLocalDatasource dataSource;
  const cityName = 'São Luís';

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    dataSource = FssWeatherLocalDatasource(storage: mockStorage);
  });

  tearDown(() {
    reset(mockStorage);
  });

  group('Weather local datasource =>', () {
    group('current weather => ', () {
      test(
          'should return weather model when currentWeather is called and data is cached',
          () async {
        when(() => mockStorage.read(key: '${cityName}_current_weather'))
            .thenAnswer((_) async => jsonEncode(weatherCacheJson));

        final result = await dataSource.currentWeather(city: cityName);

        expect(result, weatherModelSample);
        verify(() => mockStorage.read(key: '${cityName}_current_weather'))
            .called(1);
        verifyNoMoreInteractions(mockStorage);
      });

      test(
          'should return null when currentWeather is called and no data is cached',
          () async {
        when(() => mockStorage.read(key: '${cityName}_current_weather'))
            .thenAnswer((_) async => null);

        final result = await dataSource.currentWeather(city: cityName);

        expect(result, isNull);
        verify(() => mockStorage.read(key: '${cityName}_current_weather'))
            .called(1);
        verifyNoMoreInteractions(mockStorage);
      });
    });

    group('forecast weather =>', () {
      test(
          'should return list of weather models when forecastWeather is called and data is cached',
          () async {
        when(() => mockStorage.read(key: '${cityName}_forecast_weather'))
            .thenAnswer((_) async => jsonEncode([weatherCacheJson]));

        final result = await dataSource.forecastWeather(city: cityName);

        expect(result, [weatherModelSample]);
        verify(() => mockStorage.read(key: '${cityName}_forecast_weather'))
            .called(1);
        verifyNoMoreInteractions(mockStorage);
      });

      test(
          'should return null when forecastWeather is called and no data is cached',
          () async {
        when(() => mockStorage.read(key: '${cityName}_forecast_weather'))
            .thenAnswer((_) async => null);

        final result = await dataSource.forecastWeather(city: cityName);

        expect(result, isNull);
        verify(() => mockStorage.read(key: '${cityName}_forecast_weather'))
            .called(1);
        verifyNoMoreInteractions(mockStorage);
      });
    });

    group('cache current weather =>', () {
      test('should cache current weather when setCurrentWeather is called',
          () async {
        const cacheKey = '${cityName}_current_weather';
        final cacheValue = jsonEncode(weatherModelSample.toJson());
        when(() => mockStorage.write(key: cacheKey, value: cacheValue))
            .thenAnswer((_) async {});

        await dataSource.setCurrentWeather(
            city: cityName, data: weatherModelSample);

        verify(() => mockStorage.write(key: cacheKey, value: cacheValue))
            .called(1);
        verifyNoMoreInteractions(mockStorage);
      });
    });

    group('cache forecast weather', () {
      test('should cache forecast weather when setForecastWeather is called',
          () async {
        const cacheKey = '${cityName}_forecast_weather';
        when(() => mockStorage.write(
            key: cacheKey,
            value: jsonEncode([weatherCacheJson]))).thenAnswer((_) async {});

        await dataSource
            .setForecastWeather(city: cityName, data: [weatherModelSample]);

        verify(() => mockStorage.write(
            key: cacheKey, value: jsonEncode([weatherCacheJson]))).called(1);
        verifyNoMoreInteractions(mockStorage);
      });
    });
  });
}
