import 'package:http/http.dart' as http;
import 'dart:convert';
import 'weather_errors.dart';

const String apiKey = 'ec7017fcfb8fd3c151ff2dc0d296a4f6';

class Weather {
  Weather(this.lat, this.lon);

  final double? lat;
  final double? lon;
  Future<List<dynamic>> getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey'));
    if (response.statusCode == 200) {
      var mapResponse = jsonDecode(response.body)['list'].toList();
      print(mapResponse[0]);
      List<dynamic> finale =
          mapResponse.map((hour) => WeatherState.fromJson(hour)).toList();
      return finale;
    } else {
      throw NoAccess();
    }
  }

  Future<List<dynamic>> getCityData(String city) async {
    http.Response response = await http.get(Uri.parse(
        'api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey'));
    if (response.statusCode == 200) {
      var mapResponse = jsonDecode(response.body)['list'].toList();
      print(mapResponse[0]);
      List<dynamic> finale =
          mapResponse.map((hour) => WeatherState.fromJson(hour)).toList();
      return finale;
    } else {
      throw NoAccess();
    }
  }
}

class WeatherState {
  final double avgtemp;
  final double tempMin;
  final double tempMax;
  final int humidity;
  final String weather;
  final int weatherId;
  final DateTime dateTime;
  final String? icon;
  final double windspeed;
  final double? rainProb;

  const WeatherState({
    required this.avgtemp,
    required this.tempMin,
    required this.tempMax,
    required this.humidity,
    required this.weather,
    required this.dateTime,
    required this.weatherId,
    this.icon,
    required this.windspeed,
    this.rainProb,
  });

  factory WeatherState.fromJson(Map<dynamic, dynamic> json) {
    return WeatherState(
      //273.15 is converting from kelvin to celsius
      avgtemp: json['main']['temp'] - 273.15,
      tempMin: json['main']['temp_min'] - 273.15,
      tempMax: json['main']['temp_max'] - 273.15,
      humidity: json['main']['humidity'],
      weather: json['weather'][0]['main'],
      weatherId: json['weather'][0]['id'],
      icon: json['weather'][0]['icon'],
      windspeed: json['wind']['speed'].toDouble(),
      //if json['rain'] is null just set the probability with 0 and its supposed to return a map of string dynamic
      //but just to hold it right now till its solved i can use two varaibles to solve it but too lazy
      rainProb: json['rain'] ?? 0.0,
      dateTime: DateTime.parse(json['dt_txt']),
    );
  }
}
