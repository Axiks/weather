import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app_weather/models/models.dart';

class WeatherApiClient {
  static const baseUrl = 'http://api.openweathermap.org';
  static const token = 'ecac0cff9381cfa0877aab7e79a86a43';
  final http.Client httpClient;

  WeatherApiClient({
    @required this.httpClient,
  }) : assert(httpClient != null);

  Future<int> getLocationId(String city) async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {'q': '$city', 'appid': '$token', 'units': 'metric', 'lang':'ua'});
    print(url.hasAbsolutePath.toString());

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    // if (response.statusCode == 200) {
    //   var jsonResponse = jsonDecode(response.body);
    //   var itemCount = jsonResponse['totalItems'];
    //   print('Number of books about http: $itemCount.');
    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }

    print('Status code: ' + response.statusCode.toString());
    if (response.statusCode != 200) {
      print('error getting locationId for city');
      throw Exception('error getting locationId for city');
    }
    else{
      print('Greet get data');
      print(response.body.toString());
    }

    print('OK!. => locationJson');
    try {
      final locationJson = jsonDecode(response.body);
      print(locationJson.toString());
      print('City Name: $city\nCity ID: ' + (locationJson)['id'].toString());
      return (locationJson)['id'];
    }
    catch(e) {
      //Handle all other exceptions
      print(e);
    }
  }

  Future<Weather> fetchWeather(int locationId) async {
    var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {'id': '$locationId', 'appid': '$token', 'units': 'metric', 'lang':'ua'});
    print(url.hasAbsolutePath.toString());

    // final weatherUrl = '$baseUrl/data/2.5/weather?id=$locationId&appid=$token&units=metric';
    // final weatherResponse = await this.httpClient.get(Uri.parse(weatherUrl));

    var response = await http.get(url);

    if (response.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(response.body);
    print('City ID: $locationId');
    //print(weatherJson);

    try {
      Weather x = Weather.fromJson(weatherJson);
      print("XXXXXXXXXXXXXXXXXXXXXXXXX TempMAx: " + x.maxTemp.toString());
    }
    catch(e){
      print("Json Decode error:" + e);
    }
    return Weather.fromJson(weatherJson);
  }

}