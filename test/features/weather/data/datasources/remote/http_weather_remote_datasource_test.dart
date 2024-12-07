import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:weather_track_app/features/weather/data/datasources/remote/http_weather_remote_datasource.dart';
import 'package:weather_track_app/features/weather/data/datasources/remote/i_weather_remote_datasource.dart';

import '../../../../../fixtures/json/weather_json.dart';
import '../../../../../fixtures/samples/weather_model_sample.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late MockClient mockClient;
  late IWeatherRemoteDatasource dataSource;
  const apiKey = 'fake_api_key';
  const cityName = 'São Luís';

  setUp(() {
    mockClient = MockClient();
    dataSource =
        HttpWeatherRemoteDatasource(client: mockClient, apiKey: apiKey);
  });

  tearDown(() {
    reset(mockClient);
  });

  group('Weather remote datasource =>', () {
    group('current weather =>', () {
      test(
          'should return weather model when currentWeather is called and response is successful',
          () async {
        when(() => mockClient.get(Uri.parse(
                'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey')))
            .thenAnswer((_) async =>
                http.Response(jsonEncode(currentWeatherApiResponseJson), 200));

        final result = await dataSource.currentWeather(city: cityName);

        expect(result, weatherModelSample);
        verify(() => mockClient.get(Uri.parse(
                'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey')))
            .called(1);
        verifyNoMoreInteractions(mockClient);
      });

      test(
          'should throw exception when currentWeather is called and response is unsuccessful',
          () async {
        when(() => mockClient.get(Uri.parse(
                'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey')))
            .thenAnswer(
                (_) async => http.Response('Failed to load weather', 404));

        call() => dataSource.currentWeather(city: cityName);

        await expectLater(call, throwsException);
        verify(() => mockClient.get(Uri.parse(
                'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey')))
            .called(1);
        verifyNoMoreInteractions(mockClient);
      });
    });

    group('forecast weather =>', () {
      test(
          'should return list of weather models when forecastWeather is called and response is successful',
          () async {
        when(() => mockClient.get(Uri.parse(
                'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey')))
            .thenAnswer((_) async =>
                http.Response(jsonEncode(forecastWeatherApiResponse), 200));

        final result = await dataSource.forecastWeather(city: cityName);

        expect(result, [weatherModelSample]);
        verify(() => mockClient.get(Uri.parse(
                'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey')))
            .called(1);
        verifyNoMoreInteractions(mockClient);
      });

      test(
          'should throw exception when forecastWeather is called and response is unsuccessful',
          () async {
        when(() => mockClient.get(Uri.parse(
                'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey')))
            .thenAnswer(
                (_) async => http.Response('Failed to load forecast', 404));

        call() => dataSource.forecastWeather(city: cityName);

        expect(call, throwsException);
        verify(() => mockClient.get(Uri.parse(
                'https://api.openweathermap.org/data/2.5/forecast?q=$cityName&appid=$apiKey')))
            .called(1);
        verifyNoMoreInteractions(mockClient);
      });
    });
  });
}
