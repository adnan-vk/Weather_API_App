import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/service/weather_service.dart';

class WeatherProvider extends ChangeNotifier {
  TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  WeatherModel? weather;

  final WeatherService weatherService = WeatherService();
  Future<WeatherModel?> fetchWeatherDataByCity(city, context) async {
    isLoading = true;
    notifyListeners();
    try {
      weather = await weatherService.fetchWeatherDataByCity(city, context);
    } catch (e) {
      log('Exception occurred while fetching weather: $e');

      weather = null;
    } finally {
      isLoading = false;
      notifyListeners();
    }
    return weather;
  }

  void searchCity(BuildContext context) {
    fetchWeatherDataByCity(searchController.text.trim(), context);
    searchController.clear();
    notifyListeners();
  }
}