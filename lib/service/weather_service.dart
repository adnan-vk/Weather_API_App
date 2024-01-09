// ignore_for_file: non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather/model/weather_model.dart';
import 'package:weather/secrets/api.dart';
import 'package:http/http.dart' as http;

class WeatherServiceProvider extends ChangeNotifier {
  WeatherModel? _weather;
  WeatherModel? get weather => _weather;

  bool _isLoading = false;
  bool get isloading => _isLoading;

  String _errors = "";
  String? get errors => _errors;

  Future<void> FetchWeatherDataByCity(String city, context) async {
    _isLoading = true;
    _errors = "";

    try {
      final apiurl =
          "${APIEndPoints().cityurl}$city&appid=${APIEndPoints().apikey}${APIEndPoints().unit}";

      final response = await http.get(Uri.parse(apiurl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        _weather = WeatherModel.fromJson(data);
        notifyListeners();
      } else {
        final snackbar = SnackBar(
            backgroundColor: Colors.red, content: Text("City Not Found"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        _errors = "failed to load data";
      }
    } catch (e) {
      _errors = "fail to load data $e";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
