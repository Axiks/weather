import 'dart:async';

import 'package:meta/meta.dart';

import 'package:flutter_app_weather/repositories/weather_api_client.dart';
import 'package:flutter_app_weather/models/models.dart';

class WeatherRepository {
  final WeatherApiClient weatherApiClient;

  WeatherRepository({@required this.weatherApiClient})
      : assert(weatherApiClient != null);

  Future<Weather> getWeather(String city) async {
    print('do it!');
    final int locationId = await weatherApiClient.getLocationId(city);
    print('do it! 2');
    try {
      final wet = weatherApiClient.fetchWeather(locationId);
      print("Wet success");
      return wet;
    }
    catch(e){
      print("Wet error");
      print(e);
    }
  }
}