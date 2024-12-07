import 'package:weather_track_app/features/weather/data/models/weather_model.dart';

const weatherModelSample = WeatherModel(
  id: 3165523,
  dt: 1726660758,
  main: MainModel(
    temp: 284.2,
    tempMin: 283.06,
    tempMax: 286.82,
    humidity: 60,
  ),
  name: 'Province of Turin',
  weathers: [
    WeatherInfoModel(
      id: 501,
      main: 'Rain',
      description: 'moderate rain',
      icon: '10d',
    )
  ],
);
