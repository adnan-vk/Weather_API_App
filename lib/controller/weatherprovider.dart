import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/service/weather_service.dart';

class WeatherProvider with ChangeNotifier {
  WeatherModel? _weather;
  WeatherModel? get weather => _weather;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _errors = "";
  String? get errors => _errors;

  final WeatherService _weatherService = WeatherService();

  Future<void> fetchWeatherDataByCity(String city) async {
    _isLoading = true;
    _errors = "";

    try {
      _weather = await _weatherService.fetchWeatherDataByCity(city);

      if (_weather != null) {
        notifyListeners();
      } else {
        _errors = "Failed to load data";
      }
    } catch (e) {
      _errors = "Failed to load data: $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
