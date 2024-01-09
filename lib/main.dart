import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/controller/homeprovider.dart';
import 'package:weather/controller/location_provider.dart';
import 'package:weather/screens/home_page.dart';
import 'package:weather/service/weather_service.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LocatorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => WeatherServiceProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => homeprovider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
