import 'package:flutter/material.dart';
import 'package:projet_meteo/Pages/MeteoPage.dart';
import 'Pages/addCity.dart';
import 'Pages/details.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Meteo',
      debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => MeteoPage(),
          '/addCity': (context) => addCity(),
          '/details': (context) => details(),

        },
        initialRoute: '/');
  }

}






