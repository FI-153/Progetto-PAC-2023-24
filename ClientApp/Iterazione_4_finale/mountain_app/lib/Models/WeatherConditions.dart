import 'package:flutter/material.dart';

class WeatherConditions {
  final String description;
  final double avgTmp;
  final IconData icon;

  WeatherConditions(this.icon, this.description, this.avgTmp);

  WeatherConditions.fromJson(Map<String, dynamic> json)
      : description = json['descr'],
        avgTmp = json['avgTmp'],
        icon = converStringToIcon(json['icon']);

  static WeatherConditions weatherMock = WeatherConditions(
    Icons.cloud,
    "La temperatura massima sarà di 8.9℃ e la minima di -1℃, con una probabilità che piova del 0%.",
    10.2,
  );

  static IconData converStringToIcon(String iconName) {
    switch (iconName) {
      case "snow":
        return Icons.snowing;
      case "fog":
        return Icons.foggy;
      case 'wind':
        return Icons.wind_power;
      case 'cloudy':
        return Icons.cloud;
      case 'rain':
        return Icons.cloudy_snowing;

      default:
        return Icons.sunny;
    }
  }
}
