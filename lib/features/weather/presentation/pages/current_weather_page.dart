import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_track_app/core/config.dart';

import '../bloc/current_weather/current_weather_bloc.dart';
import '../widgets/weather_card_widget.dart';

class CurrentWeatherPage extends StatefulWidget {
  const CurrentWeatherPage({super.key});

  @override
  State<CurrentWeatherPage> createState() => _CurrentWeatherPageState();
}

class _CurrentWeatherPageState extends State<CurrentWeatherPage> {
  final _bloc = di<CurrentWeatherBloc>();

  @override
  void initState() {
    super.initState();
    _bloc.add(const LoadCurrentWeatherEvent());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const cityName = 'São Luís';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather in $cityName',
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.preview_outlined),
        onPressed: () {
          Navigator.of(context).pushNamed('/forecast');
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<CurrentWeatherBloc, CurrentWeatherState>(
          bloc: _bloc,
          buildWhen: (previous, current) =>
              current is CurrentWeatherLoading ||
              current is CurrentWeatherLoaded ||
              current is CurrentWeatherError,
          builder: (context, state) {
            if (state is CurrentWeatherLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is CurrentWeatherLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const Text(
                    'Current Weather',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: WeatherCardWidget(weather: state.weather),
                  ),
                ],
              );
            } else if (state is CurrentWeatherError) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
