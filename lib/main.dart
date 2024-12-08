import 'package:flutter/material.dart';
import 'package:weather_track_app/core/config.dart';
import 'package:weather_track_app/features/weather/presentation/pages/forecast_weather_page.dart';

import 'features/weather/presentation/pages/current_weather_page.dart';

void main() {
  init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather Tracker',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => const CurrentWeatherPage(),
        '/forecast': (context) => const ForecastWeatherPage(),
      },
    );
  }
}
