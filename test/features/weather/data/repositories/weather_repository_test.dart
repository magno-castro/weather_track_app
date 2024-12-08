import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_track_app/core/error/failures.dart';
import 'package:weather_track_app/core/network/network_info.dart';
import 'package:weather_track_app/features/weather/data/datasources/local/i_weather_local_datasource.dart';
import 'package:weather_track_app/features/weather/data/datasources/remote/i_weather_remote_datasource.dart';
import 'package:weather_track_app/features/weather/data/repositories/weather_repository.dart';

import '../../../../fixtures/samples/weather_model_sample.dart';
import '../../../../fixtures/samples/weather_sample.dart';

class MockNetworkInfo extends Mock implements INetworkInfo {}

class MockWeatherLocalDatasource extends Mock
    implements IWeatherLocalDatasource {}

class MockWeatherRemoteDatasource extends Mock
    implements IWeatherRemoteDatasource {}

void main() {
  late MockNetworkInfo mockNetworkInfo;
  late MockWeatherLocalDatasource mockLocalDatasource;
  late MockWeatherRemoteDatasource mockRemoteDatasource;
  late WeatherRepository weatherRepository;
  const cityName = 'São Luís';

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockLocalDatasource = MockWeatherLocalDatasource();
    mockRemoteDatasource = MockWeatherRemoteDatasource();
    weatherRepository = WeatherRepository(
      networkInfo: mockNetworkInfo,
      localDatasource: mockLocalDatasource,
      remoteDatasource: mockRemoteDatasource,
    );
  });

  tearDown(() {
    reset(mockNetworkInfo);
    reset(mockLocalDatasource);
    reset(mockRemoteDatasource);
  });

  group('Weather repository =>', () {
    group('current weather =>', () {
      test(
          'should fetch weather from remote and cache when not available locally',
          () async {
        when(() => mockLocalDatasource.currentWeather(city: cityName))
            .thenAnswer((_) async => null);
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDatasource.currentWeather(city: cityName))
            .thenAnswer((_) async => weatherModelSample);
        when(() => mockLocalDatasource.setCurrentWeather(
            city: cityName, data: weatherModelSample)).thenAnswer((_) async {});

        final result = weatherRepository.currentWeather(city: cityName);

        await expectLater(
            result, emitsInOrder([weatherModelSample.toEntity(), emitsDone]));
        verify(() => mockLocalDatasource.currentWeather(city: cityName))
            .called(1);
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockRemoteDatasource.currentWeather(city: cityName))
            .called(1);
        verify(() => mockLocalDatasource.setCurrentWeather(
            city: cityName, data: weatherModelSample)).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockLocalDatasource);
        verifyNoMoreInteractions(mockRemoteDatasource);
      });

      test(
          'should fetch weather from remote and cache when has available locally',
          () async {
        when(() => mockLocalDatasource.currentWeather(city: cityName))
            .thenAnswer((_) async => weatherModelSample);
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDatasource.currentWeather(city: cityName))
            .thenAnswer((_) async => weatherModelSample);
        when(() => mockLocalDatasource.setCurrentWeather(
            city: cityName, data: weatherModelSample)).thenAnswer((_) async {});

        final result = weatherRepository.currentWeather(city: cityName);

        await expectLater(
            result,
            emitsInOrder([
              weatherModelSample.toEntity(),
              weatherModelSample.toEntity(),
              emitsDone,
            ]));
        verify(() => mockLocalDatasource.currentWeather(city: cityName))
            .called(1);
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockRemoteDatasource.currentWeather(city: cityName))
            .called(1);
        verify(() => mockLocalDatasource.setCurrentWeather(
            city: cityName, data: weatherModelSample)).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockLocalDatasource);
        verifyNoMoreInteractions(mockRemoteDatasource);
      });

      test('should throw NoConnectionFailure when no network and no local data',
          () async {
        when(() => mockLocalDatasource.currentWeather(city: cityName))
            .thenAnswer((_) async => null);
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        final result = weatherRepository.currentWeather(city: cityName);

        await expectLater(
            result,
            emitsInOrder([
              emitsError(isA<NoConnectionFailure>()),
              emitsDone,
            ]));
        verify(() => mockLocalDatasource.currentWeather(city: cityName))
            .called(1);
        verify(() => mockNetworkInfo.isConnected).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockLocalDatasource);
        verifyZeroInteractions(mockRemoteDatasource);
      });

      test(
          'should throw NoConnectionFailure when no network and has local data',
          () async {
        when(() => mockLocalDatasource.currentWeather(city: cityName))
            .thenAnswer((_) async => weatherModelSample);
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        final result = weatherRepository.currentWeather(city: cityName);

        await expectLater(
            result,
            emitsInOrder([
              weatherModelSample.toEntity(),
              emitsError(isA<NoConnectionFailure>()),
              emitsDone,
            ]));
        verify(() => mockLocalDatasource.currentWeather(city: cityName))
            .called(1);
        verify(() => mockNetworkInfo.isConnected).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockLocalDatasource);
        verifyZeroInteractions(mockRemoteDatasource);
      });
    });
    group('forecast weather =>', () {
      test(
          'should fetch forecast weather from remote and cache when not available locally',
          () async {
        when(() => mockLocalDatasource.forecastWeather(city: cityName))
            .thenAnswer((_) async => null);
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDatasource.forecastWeather(city: cityName))
            .thenAnswer((_) async => [weatherModelSample]);
        when(() => mockLocalDatasource.setForecastWeather(
            city: cityName,
            data: [weatherModelSample])).thenAnswer((_) async {});

        final result = weatherRepository.forecastWeather(cities: [cityName]);

        await expectLater(
            result,
            emitsInOrder([
              [forecastWeatherSample],
              emitsDone
            ]));
        verify(() => mockLocalDatasource.forecastWeather(city: cityName))
            .called(1);
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockRemoteDatasource.forecastWeather(city: cityName))
            .called(1);
        verify(() => mockLocalDatasource.setForecastWeather(
            city: cityName, data: [weatherModelSample])).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockLocalDatasource);
        verifyNoMoreInteractions(mockRemoteDatasource);
      });

      test(
          'should fetch forecast weather from remote and cache when has available locally',
          () async {
        when(() => mockLocalDatasource.forecastWeather(city: cityName))
            .thenAnswer((_) async => [weatherModelSample]);
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(() => mockRemoteDatasource.forecastWeather(city: cityName))
            .thenAnswer((_) async => [weatherModelSample]);
        when(() => mockLocalDatasource.setForecastWeather(
            city: cityName,
            data: [weatherModelSample])).thenAnswer((_) async {});

        final result = weatherRepository.forecastWeather(cities: [cityName]);

        await expectLater(
            result,
            emitsInOrder([
              [forecastWeatherSample],
              [forecastWeatherSample],
              emitsDone
            ]));
        verify(() => mockLocalDatasource.forecastWeather(city: cityName))
            .called(1);
        verify(() => mockNetworkInfo.isConnected).called(1);
        verify(() => mockRemoteDatasource.forecastWeather(city: cityName))
            .called(1);
        verify(() => mockLocalDatasource.setForecastWeather(
            city: cityName, data: [weatherModelSample])).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockLocalDatasource);
        verifyNoMoreInteractions(mockRemoteDatasource);
      });

      test(
          'should throw NoConnectionFailure when no network and no forecast data locally',
          () async {
        when(() => mockLocalDatasource.forecastWeather(city: cityName))
            .thenAnswer((_) async => null);
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        final result = weatherRepository.forecastWeather(cities: [cityName]);

        await expectLater(
            result,
            emitsInOrder([
              emitsError(isA<NoConnectionFailure>()),
              emitsDone,
            ]));
        verify(() => mockLocalDatasource.forecastWeather(city: cityName))
            .called(1);
        verify(() => mockNetworkInfo.isConnected).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockLocalDatasource);
        verifyZeroInteractions(mockRemoteDatasource);
      });

      test(
          'should throw NoConnectionFailure when no network and has forecast data locally',
          () async {
        when(() => mockLocalDatasource.forecastWeather(city: cityName))
            .thenAnswer((_) async => [weatherModelSample]);
        when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        final result = weatherRepository.forecastWeather(cities: [cityName]);

        await expectLater(
            result,
            emitsInOrder([
              [forecastWeatherSample],
              emitsError(isA<NoConnectionFailure>()),
              emitsDone,
            ]));
        verify(() => mockLocalDatasource.forecastWeather(city: cityName))
            .called(1);
        verify(() => mockNetworkInfo.isConnected).called(1);
        verifyNoMoreInteractions(mockNetworkInfo);
        verifyNoMoreInteractions(mockLocalDatasource);
        verifyZeroInteractions(mockRemoteDatasource);
      });
    });
  });
}
