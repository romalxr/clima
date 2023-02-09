import 'dart:convert';

import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;

class WeatherModel {
  final String _apiKey = '51c5bd485437f5b466169f2ef5c34f05';

  Future getWeatherByCity(String cityName) async {
    var url = Uri.https(
      'api.openweathermap.org',
      'data/2.5/weather',
      {
        'q': cityName,
        'appid': _apiKey,
        'units': 'metric',
      },
    );

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String body = response.body;
      var decodedData = jsonDecode(body);
      return decodedData;
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  Future getLocationData() async {
    Location location = Location();
    await location.getCurrentPosition();
    var lat = location.latitude;
    var lon = location.longitude;

    var url = Uri.https(
      'api.openweathermap.org',
      'data/2.5/weather',
      {
        'lat': '$lat',
        'lon': '$lon',
        'appid': _apiKey,
        'units': 'metric',
      },
    );

    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      String body = response.body;
      var decodedData = jsonDecode(body);
      return decodedData;
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }

  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
