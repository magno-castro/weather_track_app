import 'package:flutter_test/flutter_test.dart';
import 'package:weather_track_app/features/weather/data/models/weather_model.dart';
import 'package:weather_track_app/features/weather/domain/entities/weather.dart';

import '../../../../fixtures/json/weather_json.dart';
import '../../../../fixtures/samples/weather_model_sample.dart';

void main() {
  group('Weather model =>', () {
    group('to JSON =>', () {
      test('should convert WeatherModel to JSON correctly', () {
        final result = weatherModelSample.toJson();

        expect(result, weatherCacheJson);
      });
    });

    group('from JSON =>', () {
      test('should create WeatherModel from JSON correctly', () {
        final result = WeatherModel.fromJson(currentWeatherApiResponseJson);

        expect(result, weatherModelSample);
      });
    });

    group('to Entity =>', () {
      test('should convert WeatherModel to Entity correctly', () {
        final weatherEntity = Weather(
          cityName: 'Province of Turin',
          date: DateTime.fromMillisecondsSinceEpoch(1726660758),
          main: 'moderate rain',
          currentTemperature: 284.2,
          maxTemperature: 286.82,
          minTemperature: 283.06,
          humidity: 60,
        );

        final result = weatherModelSample.toEntity();

        expect(result, weatherEntity);
      });
    });
  });
}
