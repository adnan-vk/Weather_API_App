import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/controller/homeprovider.dart';
import 'package:weather/controller/location_provider.dart';
import 'package:weather/controller/weatherprovider.dart';
import 'package:weather/screens/home_page.dart';

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
          create: (context) => WeatherProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => homeprovider(),
        ),
        ChangeNotifierProvider(create: (context) => WeatherProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
