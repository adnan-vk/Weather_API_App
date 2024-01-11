import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather/controller/location_provider.dart';
import 'package:weather/controller/weatherprovide.dart';
import 'package:weather/screens/home_page.dart';

class homeprovider extends ChangeNotifier {
  Future checkInternet() async {
    var connectivityresult = await Connectivity().checkConnectivity();
    return connectivityresult != ConnectivityResult.none;
  }

  refresh(context) {
    final locationProvider =
        Provider.of<LocatorProvider>(context, listen: false);
    locationProvider.determinePosition().then((_) {
      if (locationProvider.currentLocationName != null) {
        dynamic city = locationProvider.currentLocationName?.locality;
        Provider.of<WeatherProvider>(context, listen: false)
            .fetchWeatherDataByCity(city, context);
      }
    });
    final snackbar = SnackBar(
        backgroundColor: Colors.white60,
        content: Text(
          "The page is refreshing...",
          style: TextStyle(color: Colors.black),
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }


}