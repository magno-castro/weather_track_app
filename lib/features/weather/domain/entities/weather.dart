import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final String main;
  final String iconUrl;
  final DateTime date;
  final double currentTemperature;
  final double maxTemperature;
  final double minTemperature;
  final int humidity;

  const Weather({
    required this.cityName,
    required this.main,
    required this.iconUrl,
    required this.date,
    required this.currentTemperature,
    required this.maxTemperature,
    required this.minTemperature,
    required this.humidity,
  });

  @override
  List<Object?> get props => [
        cityName,
        main,
        date,
        currentTemperature,
        maxTemperature,
        minTemperature,
        humidity,
      ];
}
