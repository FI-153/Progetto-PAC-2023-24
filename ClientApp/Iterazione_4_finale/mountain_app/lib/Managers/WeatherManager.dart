import 'dart:convert';

import 'package:mountain_app/Models/WeatherConditions.dart';
import 'package:http/http.dart' as http;
import 'package:mountain_app/Utilities/Constants.dart';

class WeatherManager {
  static WeatherManager _instance = WeatherManager._internal();

  factory WeatherManager() {
    return _instance;
  }

  WeatherManager._internal() {}

  Future<WeatherConditions> fetchWeather(String date, String location) async {
    final response = await http
        .get(Uri.parse('$baseIpGateway/events/weather/$date/$location'));

    switch (response.statusCode) {
      case 200:
        var decoded = json.decode(response.body);
        return WeatherConditions.fromJson(decoded);

      default:
        throw Exception('Fallimento');
    }
  }
}
