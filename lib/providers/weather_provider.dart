import 'package:flutter/material.dart';
import 'package:weather_app/services/weather_services.dart';
import '../models/weather.dart';


class WeatherProvider extends ChangeNotifier {
  final WeatherService _weatherService = WeatherService();
  Weather? weather;
  bool isLoading = false;

  Future<void> getWeather(String city) async {
    isLoading = true;
    notifyListeners();

    try {
      weather = await _weatherService.fetchWeather(city);
    } catch (e) {
      weather = null;
    }

    isLoading = false;
    notifyListeners();
  }
}
