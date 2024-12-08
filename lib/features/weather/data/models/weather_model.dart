import 'package:equatable/equatable.dart';
import 'package:weather_track_app/features/weather/domain/entities/weather.dart';

class WeatherModel extends Equatable {
  final int id;
  final String name;
  final MainModel main;
  final int dt;
  final List<WeatherInfoModel> weathers;

  const WeatherModel({
    required this.id,
    required this.name,
    required this.main,
    required this.dt,
    required this.weathers,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'main': main.toJson(),
      'dt': dt,
      'weather': weathers.map((weather) => weather.toJson()).toList(),
    };
  }

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      id: json['id'],
      main: MainModel.fromJson(json['main']),
      name: json['name'],
      dt: json['dt'],
      weathers: List<WeatherInfoModel>.from(
          json['weather']!.map((json) => WeatherInfoModel.fromJson(json))),
    );
  }

  Weather toEntity() => Weather(
        cityName: name,
        iconUrl:
            'https://openweathermap.org/img/wn/${weathers.first.icon}@2x.png',
        date: DateTime.fromMillisecondsSinceEpoch(dt),
        main: weathers.first.description,
        currentTemperature: main.temp,
        maxTemperature: main.tempMax,
        minTemperature: main.tempMin,
        humidity: main.humidity,
      );

  @override
  List<Object> get props {
    return [
      id,
      name,
      main,
      dt,
      weathers,
    ];
  }
}

class WeatherInfoModel extends Equatable {
  final int id;
  final String main;
  final String description;
  final String icon;

  const WeatherInfoModel({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });

  WeatherInfoModel copyWith({
    int? id,
    String? main,
    String? description,
    String? icon,
  }) {
    return WeatherInfoModel(
      id: id ?? this.id,
      main: main ?? this.main,
      description: description ?? this.description,
      icon: icon ?? this.icon,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'main': main,
      'description': description,
      'icon': icon,
    };
  }

  factory WeatherInfoModel.fromJson(Map<String, dynamic> map) {
    return WeatherInfoModel(
      id: map['id']?.toInt() ?? 0,
      main: map['main'] ?? '',
      description: map['description'] ?? '',
      icon: map['icon'] ?? '',
    );
  }

  @override
  List<Object> get props => [id, main, description, icon];
}

class MainModel extends Equatable {
  final double temp;
  final double tempMin;
  final double tempMax;

  final int humidity;

  const MainModel({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
  });

  MainModel copyWith({
    double? temp,
    double? tempMin,
    double? tempMax,
    int? humidity,
  }) {
    return MainModel(
      temp: temp ?? this.temp,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      humidity: humidity ?? this.humidity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temp': temp,
      'temp_min': tempMin,
      'temp_max': tempMax,
      'humidity': humidity,
    };
  }

  factory MainModel.fromJson(Map<String, dynamic> map) {
    return MainModel(
      temp: map['temp']?.toDouble() ?? 0.0,
      tempMin: map['temp_min']?.toDouble() ?? 0.0,
      tempMax: map['temp_max']?.toDouble() ?? 0.0,
      humidity: map['humidity']?.toInt() ?? 0,
    );
  }

  @override
  List<Object?> get props {
    return [
      temp,
      tempMin,
      tempMax,
      humidity,
    ];
  }
}
