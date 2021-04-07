import 'package:flutter_app_weather/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_weather/repositories/repositories.dart';
import 'package:flutter_app_weather/repositories/weather_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'app.dart';

void main() async {
  final WeatherRepository weatherRepository = WeatherRepository(
    weatherApiClient: WeatherApiClient(
      httpClient: http.Client(),
    ),
  );

  runApp(App(weatherRepository: weatherRepository));
}