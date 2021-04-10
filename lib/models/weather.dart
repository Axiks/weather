import 'package:equatable/equatable.dart';

enum WeatherCondition {
  snow,
  sleet,
  hail,
  thunderstorm,
  heavyRain,
  lightRain,
  showers,
  heavyCloud,
  lightCloud,
  clear,
  unknown
}

class Weather extends Equatable {
  final WeatherCondition condition;
  final String formattedCondition;
  final double minTemp;
  final double temp;
  final double maxTemp;
  final int locationId;
  final String created;
  final DateTime lastUpdated;
  final String location;

  const Weather({
    this.condition,
    this.formattedCondition,
    this.minTemp,
    this.temp,
    this.maxTemp,
    this.locationId,
    this.created,
    this.lastUpdated,
    this.location,
  });

  @override
  List<Object> get props => [
    condition,
    formattedCondition,
    minTemp,
    temp,
    maxTemp,
    locationId,
    created,
    lastUpdated,
    location,
  ];

  static Weather fromJson(dynamic json) {
    print("Weather fromJson Start!");
    print(json.toString());
    try{
      print("Test temp Max: " + json['main']['temp_max'].toString());
    }catch(e){
      print("Test error: " + e);
    }

    try{
      double temp_min = double.parse(json['main']['temp_min'].toString());
      double temp = double.parse(json['main']['temp'].toString());
      double temp_max = double.parse(json['main']['temp_max'].toString());
      Weather wet =  Weather(
        // condition: _mapStringToWeatherCondition(
        //     consolidatedWeather['weather_state_abbr']),
        // formattedCondition: consolidatedWeather['weather_state_name'],
        // minTemp: consolidatedWeather['min_temp'] as double,
        // temp: consolidatedWeather['the_temp'] as double,
        // maxTemp: consolidatedWeather['max_temp'] as double,
        // locationId: json['woeid'] as int,
        // created: consolidatedWeather['created'],
        // lastUpdated: DateTime.now(),
        // location: json['title'],
        condition: _mapStringToWeatherCondition(
            json['weather'][0]['main']),
        formattedCondition: json['weather'][0]['description'].toString(),
        minTemp: temp_min as double,
        temp: temp as double,
        maxTemp:  temp_max as double,
        locationId: json['id'] as int,
        created: DateTime.now().toString(),
        lastUpdated: DateTime.now(),
        location: json['name'].toString(),
      );
      print("Weather obj success");
      return wet;
    }catch(e){
      print("Weather obj error: " + e);
    }
  }

  static WeatherCondition _mapStringToWeatherCondition(String input) {
    WeatherCondition state;
    switch (input) {
      case 'Snow':
        state = WeatherCondition.snow;
        break;
      case 'Snow':
        state = WeatherCondition.sleet;
        break;
      case 'Snow':
        state = WeatherCondition.hail;
        break;
      case 'Thunderstorm':
        state = WeatherCondition.thunderstorm;
        break;
      case 'Rain':
        state = WeatherCondition.heavyRain;
        break;
      case 'Rain':
        state = WeatherCondition.lightRain;
        break;
      case 'Rain':
        state = WeatherCondition.showers;
        break;
      case 'Clouds':
        state = WeatherCondition.heavyCloud;
        break;
      case 'Clouds':
        state = WeatherCondition.lightCloud;
        break;
      case 'Clear':
        state = WeatherCondition.clear;
        break;
      default:
        state = WeatherCondition.unknown;
    }
    return state;
  }
}