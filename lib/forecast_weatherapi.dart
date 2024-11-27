import 'dart:convert';
import 'package:flutter_weather_app/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WeatherForcast extends GetxController {
  var forecastList = {};
  var isLoader = false.obs;

  Future<void> getWeatherForecast(String location) async {
    String apiUrl = "$baseUrl/forecast.json?key=$apiKey&q=$location";

    try {
      isLoader(true);
      var response = await http.get(Uri.parse(apiUrl), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        forecastList = jsonDecode(response.body);
        print('-+++++++++++++++++++++++++++++++++++++++++');
        print(
            "forecast time and temp- ${forecastList['forecast']['forecastday'][0]['hour'][0]['time']}");
        print('-+++++++++++++++++++++++++++++++++++++++++');
        print("Forecast data loaded successfully");
      } else {
        print("Failed to fetch forecast data: ${response.statusCode}");
      }
      print("forecastReport${response.body}");
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoader(false);
    }
  }
}
