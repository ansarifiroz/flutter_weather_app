import 'package:flutter_weather_app/current_weatherapi.dart';
import 'package:flutter_weather_app/forecast_weatherapi.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

final weatherReport = Get.put(WeatherController());
final forecastReport = Get.put(WeatherForcast());

getLocationPermission() async {
  bool servieEnabled;
  LocationPermission permission;

  servieEnabled = await Geolocator.isLocationServiceEnabled();
  if (!servieEnabled) {
    return;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return;
  }
  Position currentLocation = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  print('---------------------------------');
  print(currentLocation);
  print('---------------------------------');
  weatherReport.getCurrentWeather(
      "${currentLocation.latitude},${currentLocation.longitude}");
  forecastReport.getWeatherForecast(
      "${currentLocation.latitude},${currentLocation.longitude}");
}
