import 'package:flutter/material.dart';
import 'package:flutter_app_weather/repositories/weather_repository.dart';
import 'package:flutter_app_weather/widgets/weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'blocs/weather_bloc.dart';

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  App({Key key, @required this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather',
      home: BlocProvider(
        create: (context) =>
            WeatherBloc(weatherRepository: weatherRepository),
        child: Weather(),
      ),
    );
  }
}