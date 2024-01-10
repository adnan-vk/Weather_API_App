import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:weather/model/weather_model.dart';
import 'package:weather/secrets/api.dart';

class WeatherService {
  Future<WeatherModel?> fetchWeatherDataByCity(String city, context) async {
    try {
      final String apiUrl =
          '${APIEndPoints().cityurl}${city}&appid=${APIEndPoints().apikey}${APIEndPoints().unit}';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // log('$data');
        return WeatherModel.fromJson(data);
      } else {
        
        log('Error:${response.statusCode}');
        return null;
      }
    } catch (e) {
      log('Exception:$e');
      return null;
    }
  }
}