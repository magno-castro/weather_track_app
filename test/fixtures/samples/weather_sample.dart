import 'package:weather_track_app/features/weather/domain/entities/weather.dart';

final weatherSample = Weather(
  main: 'Sunny',
  date: DateTime(2024, 12, 7),
  currentTemperature: 30,
  humidity: 60,
  maxTemperature: 35,
  minTemperature: 25,
  cityName: 'São Luís',
);

final forecastWeatherSample = [
  Weather(
    cityName: 'São Luís',
    main: 'Clear',
    date: DateTime(2024, 12, 8),
    currentTemperature: 30.0,
    maxTemperature: 32.0,
    minTemperature: 28.0,
    humidity: 60.0,
  ),
  Weather(
    cityName: 'São Luís',
    main: 'Cloudy',
    date: DateTime(2024, 12, 9),
    currentTemperature: 29.0,
    maxTemperature: 31.0,
    minTemperature: 27.0,
    humidity: 65.0,
  ),
  Weather(
    cityName: 'São Luís',
    main: 'Rain',
    date: DateTime(2024, 12, 10),
    currentTemperature: 25.0,
    maxTemperature: 28.0,
    minTemperature: 23.0,
    humidity: 85.0,
  ),
  Weather(
    cityName: 'São Luís',
    main: 'Thunderstorm',
    date: DateTime(2024, 12, 11),
    currentTemperature: 26.0,
    maxTemperature: 27.0,
    minTemperature: 24.0,
    humidity: 90.0,
  ),
  Weather(
    cityName: 'São Luís',
    main: 'Sunny',
    date: DateTime(2024, 12, 12),
    currentTemperature: 31.0,
    maxTemperature: 33.0,
    minTemperature: 29.0,
    humidity: 55.0,
  ),
];