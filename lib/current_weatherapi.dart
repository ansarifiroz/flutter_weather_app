import 'dart:convert';
import 'package:flutter_weather_app/constant.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class WeatherController extends GetxController {
  var weatherList = [].obs;
  var isLoader = false.obs;

  Future<void> getCurrentWeather(String location) async {
    print(location);
    String apiUrl = "$baseUrl/current.json?key=$apiKey&q=$location";

    try {
      isLoader(true);
      var response = await http.get(Uri.parse(apiUrl), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        weatherList.value = [jsonDecode(response.body)];
        print("Weather data loaded successfully");
      } else {
        print("Failed to fetch data: ${response.statusCode}");
      }
      print(response.body);
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoader(false);
    }
  }
}
