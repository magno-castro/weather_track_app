import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_track_app/core/config.dart';
import 'package:weather_track_app/features/weather/presentation/widgets/weather_card_widget.dart';

import '../bloc/forecast_weather/forecast_weather_bloc.dart';

class ForecastWeatherPage extends StatefulWidget {
  const ForecastWeatherPage({super.key});

  @override
  State<ForecastWeatherPage> createState() => _ForecastWeatherPageState();
}

class _ForecastWeatherPageState extends State<ForecastWeatherPage> {
  final TextEditingController _searchController = TextEditingController();
  final _bloc = di<ForecastWeatherBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(const LoadForecastWeatherEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tour Weather Tracker'),
      ),
      body: BlocBuilder<ForecastWeatherBloc, ForecastWeatherState>(
        bloc: _bloc,
        buildWhen: (previous, current) =>
            current is ForecastWeatherLoading ||
            current is ForecastWeatherLoaded ||
            current is ForecastWeatherError,
        builder: (context, state) {
          if (state is ForecastWeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ForecastWeatherLoaded) {
            var forecasts = state.forecast;

            return StatefulBuilder(builder: (context, setState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Search by city',
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          forecasts = state.forecast
                              .where((f) => f.cityName.contains(value))
                              .toList();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        for (var forecast in forecasts) ...{
                          Text(
                            forecast.cityName,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          ...forecast.weathers.map(
                              (weather) => WeatherCardWidget(weather: weather)),
                        }
                      ],
                    ),
                  ),
                ],
              );
            });
          } else if (state is ForecastWeatherError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
