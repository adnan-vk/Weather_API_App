import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather/model/weather_model.dart';
import 'package:weather/secrets/api.dart';

class WeatherService {
  Future<WeatherModel?> fetchWeatherDataByCity(String city) async {
    try {
      final apiurl =
          "${APIEndPoints().cityurl}$city&appid=${APIEndPoints().apikey}${APIEndPoints().unit}";

      final response = await http.get(Uri.parse(apiurl));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return WeatherModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
