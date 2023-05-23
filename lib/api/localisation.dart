import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<Loca> fetchLoca(ville) async {
  print(ville.runtimeType);
  final response = await http
      .get(Uri.parse('https://api.opencagedata.com/geocode/v1/json?q=${ville}&key=adc0365569a84e0c96a76d699bc6efbb&pretty=1&no_annotations=1&types=city'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    var responseData = jsonDecode(response.body);

    // Accéder à la liste des résultats
    var results = responseData['results'];

// Parcourir les résultats
    var geometry;
    //print(results);
    /*for (var result in results) {
      // Accéder aux données de géométrie
      geometry = result['geometry'];
    }*/

    geometry = responseData['results'][0]['geometry'];
    print(geometry);
    return Loca.fromJson(geometry);

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

class Loca {
  final double latitude;
  final double longitude;

  const Loca({
    required this.latitude,
    required this.longitude,
  });

  factory Loca.fromJson(Map<String, dynamic> json) {
    return Loca(
      latitude: json['lat'],
      longitude: json['lng'],

    );
  }
}

class LocaBloc {
  final _albumController = StreamController<Loca>(); // Créez un contrôleur de flux pour émettre l'album
  Stream<Loca> get albumStream => _albumController.stream; // Définissez un getter pour accéder au flux de l'album

  Future<void> fetchLoca2(ville) async {
    try {
      final loca = await fetchLoca(ville); // Appelez votre méthode pour récupérer l'album depuis votre API
      _albumController.sink.add(loca); // Émettez l'album vers le flux
    } catch (error) {
      _albumController.addError(error); // Gérez les erreurs lors de la récupération de l'album
    }
  }

  void dispose() {
    _albumController.close(); // Fermez le contrôleur de flux lorsqu'il n'est plus utilisé pour éviter les fuites de mémoire
  }
}

/*class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var test = snapshot.data!.longitude.toString();
                return Text(test);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
*/