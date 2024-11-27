import 'package:flutter/material.dart';
import 'package:flutter_weather_app/current_weatherapi.dart';
import 'package:flutter_weather_app/forecast_weatherapi.dart';
import 'package:flutter_weather_app/locationpermission.dart';
import 'package:get/get.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final weatherReport = Get.put(WeatherController());
  final forecastReport = Get.put(WeatherForcast());

  @override
  void initState() {
    super.initState();
    getLocationPermission();
    // forecastReport.getWeatherForecast(location);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(
            () => weatherReport.isLoader.value
                ? const Center(child: CircularProgressIndicator())
                : weatherReport.weatherList.isEmpty
                    ? const Text("No data available")
                    : Container(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            searchBarBuild(),
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "${weatherReport.weatherList[0]['location']['localtime']}"
                                    .substring(0, 10),
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 50,
                                ),
                                Text(
                                  "${weatherReport.weatherList[0]['location']['name']}",
                                  style: const TextStyle(fontSize: 40),
                                ),
                                Text(
                                  "${weatherReport.weatherList[0]['location']['region']}",
                                  style: const TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    "${weatherReport.weatherList[0]['current']['temp_c']}°c",
                                    style: const TextStyle(
                                        fontSize: 60,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "${weatherReport.weatherList[0]['current']['condition']['text']}",
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: Image.network(
                                  "https:${weatherReport.weatherList[0]['current']['condition']['icon']}",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            otherDetails(),
                            const SizedBox(
                              height: 20,
                            ),
                            hourlyDetails(),
                            const TextButton(
                                onPressed: (getLocationPermission),
                                child: Text(
                                  "Get current loation",
                                  style: TextStyle(fontSize: 20),
                                )),
                            // carsoulSlder(),
                            // dailyForecaset(),
                          ],
                        ),
                      ),
          ),
        ),
      ),
    );
  }

  Widget searchBarBuild() {
    return TextField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        prefixIcon: const Icon(Icons.search),
        hintText: "Search by location",
      ),
      onSubmitted: (value) {
        weatherReport.getCurrentWeather(value);
        forecastReport.getWeatherForecast(value);
      },
    );
  }

  // Widget carsoulSlder() {
  //   return CarouselSlider(
  //     options: CarouselOptions(
  //       height: 310.0,
  //       enableInfiniteScroll: false,
  //       viewportFraction: 1,
  //       animateToClosest: false,
  //     ),
  //     items: [1, 2].map((i) {
  //       return Builder(
  //         builder: (BuildContext context) {
  //           return otherDetails();
  //         },
  //       );
  //     }).toList(),
  //   );
  // }

  Widget otherDetails() {
    return Card(
      color: Colors.grey.shade50,
      child: SizedBox(
        height: 300,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "${weatherReport.weatherList[0]['current']['humidity']}%",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        'Humidity',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "${weatherReport.weatherList[0]['current']['wind_kph']} km/h",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        'Wind Speed',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "${weatherReport.weatherList[0]['current']['uv']}",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        'UV Index',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "${weatherReport.weatherList[0]['current']['precip_mm']} mm",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        'Precipitation',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        "${weatherReport.weatherList[0]['current']['feelslike_c']}",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        "Feel's like",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        "${weatherReport.weatherList[0]['current']['wind_dir']}",
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w500),
                      ),
                      const Text(
                        'Wind direction',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget hourlyDetails() {
    return Obx(() => forecastReport.isLoader.value
        ? const Center(child: CircularProgressIndicator())
        : forecastReport.forecastList.isEmpty
            ? const Text("No data available")
            : SizedBox(
                height: 160,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 24,
                    itemBuilder: (BuildContext context, int index) {
                      int currentHour = DateTime.now().hour;

                      int hourIndex = (currentHour + index) % 24;

                      var hourData = forecastReport.forecastList['forecast']
                          ['forecastday'][0]['hour'][hourIndex];

                      return Card(
                        color: Colors.grey.shade50,
                        child: SizedBox(
                          height: 150,
                          width: 100,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("${hourData['time']}".substring(11)),
                                Image.network(
                                    "https:${hourData['condition']['icon']}"),
                                Text("${hourData['condition']['text']}"),
                                Text("${hourData['temp_c']}°c"),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              ));
  }

  // Widget dailyForecaset() {
  //   return Card(
  //     color: Colors.grey.shade50,
  //     child: SizedBox(
  //       height: 300,
  //       width: double.infinity,
  //       child: Padding(
  //         padding: EdgeInsets.all(15.0),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             const Text(
  //               'Next Day forcast',
  //               style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
  //             ),
  //             Row(
  //               children: [
  //                 // Text(
  //                 //     "${forecastReport.forecastList['forecast'][0]['forecastday']['date']}")
  //               ],
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
