import 'dart:convert';

import 'package:mountain_app/Models/WeatherConditions.dart';
import 'package:http/http.dart' as http;
import 'package:mountain_app/Utilities/Constants.dart';
import 'package:mountain_app/Utilities/Misc.dart';

class WeatherManager {
  static WeatherManager _instance = WeatherManager._internal();
  late String _baseIpGateway;

  factory WeatherManager() {
    return _instance;
  }

  WeatherManager._internal() {
    _baseIpGateway = getAddress();
  }

  Future<WeatherConditions> fetchWeather(String date, String location) async {
    date = date.split('/').reduce((value, element) => value + '-' + element);

    final response = await http
        .get(Uri.parse('$_baseIpGateway/events/weather/$date/$location'));

    switch (response.statusCode) {
      case 200:
        var decoded = json.decode(response.body);
        return WeatherConditions.fromJson(decoded);

      default:
        throw Exception('Fallimento');
    }
  }
}
