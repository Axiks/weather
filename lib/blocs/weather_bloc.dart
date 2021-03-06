import 'package:flutter_app_weather/repositories/weather_repository.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:flutter_app_weather/repositories/repositories.dart';
import 'package:flutter_app_weather/models/models.dart';
import 'package:flutter_app_weather/blocs/blocs.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null),
        super(WeatherInitial());

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is WeatherRequested) {
      yield WeatherLoadInProgress();
      try {
        print("Weather try load.//");
        final Weather weather = await weatherRepository.getWeather(event.city);
        print("Weather get success.//");
        yield WeatherLoadSuccess(weather: weather);
      } catch (e) {
        print("Weather get faill :(. Error:");
        print(e.toString());
        yield WeatherLoadFailure();
      }
    }
  }
}