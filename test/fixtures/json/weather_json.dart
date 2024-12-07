final currentWeatherApiResponseJson = {
  'coord': {'lon': 7.367, 'lat': 45.133},
  'weather': [
    {'id': 501, 'main': 'Rain', 'description': 'moderate rain', 'icon': '10d'}
  ],
  'base': 'stations',
  'main': {
    'temp': 284.2,
    'feels_like': 282.93,
    'temp_min': 283.06,
    'temp_max': 286.82,
    'pressure': 1021,
    'humidity': 60,
    'sea_level': 1021,
    'grnd_level': 910
  },
  'visibility': 10000,
  'wind': {'speed': 4.09, 'deg': 121, 'gust': 3.47},
  'rain': {'1h': 2.73},
  'clouds': {'all': 83},
  'dt': 1726660758,
  'sys': {
    'type': 1,
    'id': 6736,
    'country': 'IT',
    'sunrise': 1726636384,
    'sunset': 1726680975
  },
  'timezone': 7200,
  'id': 3165523,
  'name': 'Province of Turin',
  'cod': 200
};

final weatherCacheJson = {
  'id': 3165523,
  'name': 'Province of Turin',
  'main': {
    'temp': 284.2,
    'temp_min': 283.06,
    'temp_max': 286.82,
    'humidity': 60
  },
  'dt': 1726660758,
  'weather': [
    {
      'id': 501,
      'main': 'Rain',
      'description': 'moderate rain',
      'icon': '10d',
    }
  ],
};

final forecastWeatherApiResponse = {
  'cod': '200',
  'message': 0,
  'cnt': 40,
  'list': [
    {
      'dt': 1726660758,
      'main': {
        'temp': 284.2,
        'feels_like': 282.93,
        'temp_min': 283.06,
        'temp_max': 286.82,
        'pressure': 1021,
        'humidity': 60,
        'sea_level': 1021,
        'grnd_level': 910,
        'temp_kf': -1.11
      },
      'weather': [
        {
          'id': 501,
          'main': 'Rain',
          'description': 'moderate rain',
          'icon': '10d',
        }
      ],
      'clouds': {'all': 100},
      'wind': {'speed': 0.62, 'deg': 349, 'gust': 1.18},
      'visibility': 10000,
      'pop': 0.32,
      'rain': {'3h': 0.26},
      'sys': {'pod': 'd'},
      'dt_txt': '2022-08-30 15:00:00'
    },
  ],
  'city': {
    'id': 3165523,
    'name': 'Province of Turin',
    'coord': {'lat': 44.34, 'lon': 10.99},
    'country': 'IT',
    'population': 4593,
    'timezone': 7200,
    'sunrise': 1661834187,
    'sunset': 1661882248
  }
};
