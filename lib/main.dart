import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:projet_meteo/Pages/MeteoPage.dart';
import 'package:sqflite/sqflite.dart';
import 'Pages/addCity.dart';
import 'Pages/components.dart';
import 'Pages/details.dart';



void main()  {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    City emptyCity = City(
      name: '',
      latitude: null,
      longitude: null,
    );
    List<City> cities = [];
    return MaterialApp(
      title: 'My Meteo',
      debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => MeteoPage(cityList: cities),
          '/addCity': (context) => addCity(cityList:cities),
          '/details': (context) => details(city:emptyCity),

        },
        initialRoute: '/');
  }

}






