
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';


Future<Loca> fetchLoca(ville) async {
  print(ville.runtimeType);
  final response = await http
      .get(Uri.parse('https://api.opencagedata.com/geocode/v1/json?q=${ville}&key=adc0365569a84e0c96a76d699bc6efbb&pretty=1&no_annotations=1&types=city'));

  if (response.statusCode == 200) {
    var responseData = jsonDecode(response.body);

    var geometry = responseData['results'][0]['geometry'];
    //print(geometry);
    return Loca.fromJson(geometry);

  } else {

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
  final _locaController = StreamController<Loca>();

  Stream<Loca> get locaStream => _locaController.stream;

  Future<void> fetchLoca2(ville) async {
    try {
      final loca = await fetchLoca(ville);
      _locaController.sink.add(loca);
    } catch (error) {
      _locaController.addError(error);
    }
  }


  void dispose() {
    _locaController.close();
  }

}