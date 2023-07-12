import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = 'o00tVsDERucHyfHfzV+eXw==oM0tnrZj0iCdi4Rx';

class CityLocator {
  CityLocator(this.cityNameQuery);

  final String cityNameQuery;

  Future<List<dynamic>> queryCities() async {
    http.Response response = await http.get(
        Uri.parse(
            'https://api.api-ninjas.com/v1/city?name=$cityNameQuery&limit=30'),
        headers: {'X-Api-Key': apiKey});
    if (response.statusCode == 200) {
      var mapResponse = jsonDecode(response.body).toList();
      List<dynamic> finale =
          mapResponse.map((city) => City.fromJson(city)).toList();
      return finale;
    } else {
      throw 'Check your internet connection';
    }
  }
}

class City {
  City(
      {required this.city,
      required this.country,
      required this.lat,
      required this.lon});

  final String city;
  final String country;
  final double lat;
  final double lon;

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      city: json["name"],
      country: json['country'],
      lat: json['latitude'],
      lon: json['longitude'],
    );
  }
  @override
  String toString() {
    return '$city, $country';
  }
}
