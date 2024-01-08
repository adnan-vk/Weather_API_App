import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/controller/homeprovider.dart';
import 'package:weather/controller/location_provider.dart';
import 'package:weather/service/weather_service_provider.dart';

TextEditingController cityCoontroller = TextEditingController();

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final date = DateFormat('EEEE dd-MM-yyyy').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final weatherprovider =
        Provider.of<WeatherServiceProvider>(context, listen: false);
    Provider.of<homeprovider>(context).checkInternetAndFetchData(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.all(15),
          height: size.height,
          width: size.width,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  opacity: .7,
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/weather bg (2).jpg'))),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red),
                      const SizedBox(
                        width: 10,
                      ),
                      Consumer<LocatorProvider>(
                        builder: (context, value, child) => Column(
                          children: [
                            Text(
                              value.currentLocationName?.locality ??
                                  "unknown location",
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              value.currentLocationName?.subLocality ?? " ",
                              style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54),
                            ),
                            Text(
                              date.toString(),
                              style: const TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueGrey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text("Refresh"),
                      IconButton(
                        onPressed: () {
                          final locationProvider = Provider.of<LocatorProvider>(
                              context,
                              listen: false);
                          locationProvider.determinePosition().then((_) {
                            if (locationProvider.currentLocationName != null) {
                              dynamic city = locationProvider
                                  .currentLocationName?.locality;
                              Provider.of<WeatherServiceProvider>(context,
                                      listen: false)
                                  .FetchWeatherDataByCity(city);
                              cityCoontroller.clear();
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.refresh,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: cityCoontroller,
                      decoration: InputDecoration(
                        labelText: "Search City ...",
                        labelStyle: const TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        weatherprovider.FetchWeatherDataByCity(
                            cityCoontroller.text.trim());
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Consumer2<WeatherServiceProvider, LocatorProvider>(
                builder: (context, weathervalue, locatorvalue, child) {
                  if (locatorvalue.currentLocationName == null ||
                      weathervalue.weather == null) {
                    return const CircularProgressIndicator();
                  }
                  return Column(
                    children: [
                      Text(
                        "${weathervalue.weather!.main!.temp!.round().toString()}\u00b0c",
                        style: const TextStyle(
                          fontSize: 70,
                          fontWeight: FontWeight.w200,
                          color: Color.fromARGB(255, 30, 109, 33),
                        ),
                      ),
                      Text(
                        weathervalue.weather!.weather?[0].description
                                ?.toString() ??
                            'N/A',
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black45,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        weathervalue.weather!.name?.toString().toUpperCase() ??
                            'N/A',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 49, 68, 78)),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(
                height: 150,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 330,
                height: 150,
                child: Consumer2<WeatherServiceProvider, LocatorProvider>(
                  builder: (context, weathervalue, locatorvalue, child) {
                    if (locatorvalue.currentLocationName == null) {
                      // Display a message to select a location
                      return const Center(
                        child: Text(
                          "Select a location...",
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.red,
                          ),
                        ),
                      );
                    } else {
                      final weather = weathervalue.weather;

                      if (weather == null) {
                        return const CircularProgressIndicator();
                      }
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                'assets/images/temp_1.png',
                                width: 60,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Temp Max",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  Text(
                                    "${weather.main?.tempMax?.round().toString() ?? "N/A"}\u00b0c",
                                    style: const TextStyle(
                                        fontSize: 25, color: Colors.red),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset(
                                'assets/images/temp 2.png',
                                width: 40,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Temp Min",
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.white),
                                  ),
                                  Text(
                                    "${weather.main?.tempMin?.round().toString() ?? 'N/A'}\u00b0c",
                                    style: const TextStyle(
                                        fontSize: 25, color: Colors.blue),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.white,
                            height: 10,
                            thickness: 1.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/sun.png',
                                width: 40,
                              ),
                              Column(
                                children: [
                                  const Text(
                                    "Sunrise",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    DateFormat("hh:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                        weather.sys!.sunrise! * 1000,
                                      ),
                                    ),
                                    style:
                                        const TextStyle(color: Colors.white54),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Image.asset(
                                'assets/images/half moon.png',
                                width: 40,
                                color: Colors.white54,
                              ),
                              Column(
                                children: [
                                  const Text("Sunset",
                                      style: TextStyle(color: Colors.white)),
                                  Text(
                                    DateFormat("hh:mm a").format(
                                      DateTime.fromMillisecondsSinceEpoch(
                                        weather.sys!.sunset! * 1000,
                                      ),
                                    ),
                                    style:
                                        const TextStyle(color: Colors.white54),
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      );
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
