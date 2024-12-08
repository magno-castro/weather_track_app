import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/weather.dart';

class WeatherCardWidget extends StatelessWidget {
  final Weather weather;

  const WeatherCardWidget({
    super.key,
    required this.weather,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CachedNetworkImage(
        imageUrl: weather.iconUrl,
        width: 40.0,
        height: 40.0,
      ),
      title: Text('${weather.currentTemperature}°C, ${weather.main}'),
      subtitle:
          Text('Max: ${weather.maxTemperature} Min: ${weather.minTemperature}'),
    );
  }
}
