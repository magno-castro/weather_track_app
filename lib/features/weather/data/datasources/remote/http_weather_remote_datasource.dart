import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_track_app/core/error/failures.dart';

import '../../models/weather_model.dart';
import 'i_weather_remote_datasource.dart';

class HttpWeatherRemoteDatasource implements IWeatherRemoteDatasource {
  final http.Client client;
  final String apiKey;
  static const url = 'https://api.openweathermap.org/data/2.5';

  HttpWeatherRemoteDatasource({required this.client, required this.apiKey});

  @override
  Future<WeatherModel> currentWeather({required String city}) async {
    final response =
        await client.get(Uri.parse('$url/weather?q=$city&appid=$apiKey'));

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(body);
    } else {
      throw WeatherFailure(
        message: 'Failed to load weather',
        error: body['message'] ?? 'Unknown error',
      );
    }
  }

  @override
  Future<List<WeatherModel>> forecastWeather({required String city}) async {
    final response =
        await client.get(Uri.parse('$url/forecast?q=$city&appid=$apiKey'));

    final body = jsonDecode(response.body);

    if (response.statusCode == 200) {
      final data = body as Map<String, dynamic>;

      return (data['list'] as List)
          .map((element) => WeatherModel.fromJson({
                'id': data['city']['id'],
                'name': data['city']['name'],
                ...element,
              }))
          .toList();
    } else {
      throw WeatherFailure(
        message: 'Failed to load forecast',
        error: body['message'] ?? 'Unknown error',
      );
    }
  }
}
