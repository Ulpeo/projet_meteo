import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Meteo> fetchMeteo(lat, lng) async {
  /*var lat = 47.6034323;
  var lng = -3.0664113;*/
  final response = await http
      .get(Uri.parse('https://api.open-meteo.com/v1/forecast?latitude=${lat}&longitude=${lng}&hourly=temperature_2m,relativehumidity_2m,apparent_temperature,precipitation_probability,weathercode,windspeed_10m,winddirection_80m&daily=temperature_2m_max,temperature_2m_min,weathercode&current_weather=true&timezone=auto'));

  if (response.statusCode == 200) {

    var responseData = jsonDecode(response.body);

    return Meteo.fromJson(responseData);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load meteo');
  }
}


class Meteo{
  final double temperature;
  final double weathercode;
  final List time;
  final List min;
  final List max;
  final List hour;
  final List hourcode;
  final List daycode;
  final List rainproba;
  final List humidity;
  final double windspeed;
  final List ressenti;
  final List hourtemp;


  const Meteo({
    required this.temperature,
    required this.time,
    required this.weathercode,
    required this.min,
    required this.max,
    required this.hour,
    required this.hourcode,
    required this.daycode,
    required this.rainproba,
    required this.humidity,
    required this.windspeed,
    required this.ressenti,
    required this.hourtemp,
  });

  factory Meteo.fromJson(Map<String, dynamic> json) {
    return Meteo(
      temperature: json['current_weather']['temperature'],
      time: json['daily']['time'],
      weathercode: json['current_weather']['weathercode'],
      min: json['daily']['temperature_2m_min'],
      max: json['daily']['temperature_2m_max'],
      hour: json['hourly']['time'],
      hourcode: json['hourly']['weathercode'],
      daycode: json['daily']['weathercode'],
      rainproba: json['hourly']['precipitation_probability'],
      humidity: json['hourly']['relativehumidity_2m'],
      windspeed: json['current_weather']['windspeed'],
      ressenti: json['hourly']['apparent_temperature'],
      hourtemp: json['hourly']['temperature_2m'],


    );
  }
}


class MeteoBloc {
  final _meteoController = StreamController<Meteo>();
  Stream<Meteo> get albumStream => _meteoController.stream;
  Future<void> fetchMeteo2(lat, lng) async {
    try {
      final meteo = await fetchMeteo(lat, lng);
      _meteoController.sink.add(meteo);
    } catch (error) {
      _meteoController.addError(error);
    }
  }

  void dispose() {
    _meteoController.close();
  }
}

