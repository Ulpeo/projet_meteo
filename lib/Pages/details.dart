import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:projet_meteo/api/localisation.dart';

import '../api/meteo.dart';


String getDayOfWeek(String dateStr) {
  initializeDateFormatting('fr_FR', null);
  DateTime date = DateFormat("yyyy-MM-dd").parse(dateStr);
  String dayOfWeek = DateFormat.EEEE('fr_FR').format(date);
  dayOfWeek = dayOfWeek.substring(0, 1).toUpperCase() + dayOfWeek.substring(1);
  return dayOfWeek;
}



class details extends StatefulWidget {
  @override
  _detailsState createState() => _detailsState();
}

class _detailsState extends State<details> {
  final meteoBloc = MeteoBloc(); // Créez une instance de votre classe BLoC

  @override
  void initState() {
    super.initState();
    meteoBloc.fetchMeteo2(); // Appelez la méthode pour récupérer l'album lorsque votre page est initialisée
  }

  @override
  void dispose() {
    meteoBloc.dispose(); // Disposez de votre classe BLoC lorsque la page est supprimée
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int hour = now.hour;
    print(hour);

    return StreamBuilder<Meteo>(
      stream: meteoBloc.albumStream, // Écoutez le flux de l'album de votre classe BLoC
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final meteo = snapshot.data; // Récupérez l'album depuis le snapshot
          // Utilisez les données de l'album dans votre interface utilisateur
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0xFFF8F8F8),
              leading: IconButton(
                icon: Icon(Icons.arrow_circle_left, color: Colors.black, size: 50),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text("Paris, France",
                  style: TextStyle(
                    fontSize:30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  )),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: carteMeteo(meteo?.temperature, meteo?.min[0], meteo?.max[0]),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(getDayOfWeek(meteo?.time[0]), style:
                        TextStyle(color:Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold, fontSize: 20)),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${meteo?.min[0]}°",style:
                              TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                            ),
                            Text("${meteo?.max[0]}°",style:
                            TextStyle(color:Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold, fontSize: 20))
                          ],
                        )


                      ],
                    ),
                  ),
                  parHeure(snapshot.data),
                  parJour(getDayOfWeek(meteo?.time[1]),meteo?.min[1],meteo?.max[1]),
                  parJour(getDayOfWeek(meteo?.time[2]),meteo?.min[2],meteo?.max[2]),
                  parJour(getDayOfWeek(meteo?.time[3]),meteo?.min[3],meteo?.max[3]),
                  parJour(getDayOfWeek(meteo?.time[4]),meteo?.min[4],meteo?.max[4]),
                  Text("Plus d'infos", style:
                  TextStyle(color:Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.left,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 90,
                          child: Column(
                            children: [
                              Text("Chances de pluie", style:
                              TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                              SvgPicture.asset("umbrella-1.svg",  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn)),
                              Text("${meteo?.rainproba[hour]}%", style:
                              TextStyle(color:Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 20)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: 90,
                          child: Column(
                            children: [
                              Text("Taux d'humidité", style:
                              TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize:15 )),
                              SvgPicture.asset("rain.svg",  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn)),
                              Text("${meteo?.humidity[hour]}%", style:
                              TextStyle(color:Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 15)),
                            ],

                          ),
                        ),
                      )

                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width:90,
                          child: Column(
                            children: [
                              Text("Vent", style:
                              TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                              SvgPicture.asset("windy-1.svg",  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn)),
                              Text("${meteo?.windspeed}Km/h", style:
                              TextStyle(color:Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 15)),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width:90,
                          child: Column(
                            children: [
                              Text("Temperature ressentie", style:
                              TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
                              SvgPicture.asset("direction-1.svg",  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn)),
                              Text("${meteo?.ressenti[hour]}°", style:
                              TextStyle(color:Colors.deepPurple, fontWeight: FontWeight.bold, fontSize: 15)),
                            ],

                          ),
                        ),
                      )

                    ],
                  ),
                ],
              ),
            ),


          );



            //Text('Latitude: ${meteo?.temperature}, Longitude: ${meteo?.min}');
        } else if (snapshot.hasError) {
          // Gérez les erreurs lors de la récupération de l'album
          return Text('Erreur : ${snapshot.error}');
        }

        // Affichez un indicateur de chargement si aucune donnée n'est disponible
        return CircularProgressIndicator();
      },
    );
  }
}



Widget carteMeteo(temperature, min, max){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child:
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text("ensoleillé", style:
                      TextStyle(fontSize: 20, color: Colors.grey),),
                      Text(temperature.toString(), style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50,),),
                    ],

                  ),
                  SizedBox(
                      height:80, width: 80,
                      child: SvgPicture.asset("cloud.svg",  colorFilter: ColorFilter.mode(Colors.deepPurple, BlendMode.srcIn))),

                ],
              ),
              Text("Aujourd’hui, le temps est ensoleillé. Il y aura une minimale de ${min}° et un maximum de ${max}°.",
                  style:
                  TextStyle(fontSize: 20)),
            ],
          ),
        ),
    ),
  );
}

Widget parHeure(meteo){

  return
    CarouselSlider(
      options: CarouselOptions(height: 120.0,
        viewportFraction: 0.15,),

      items: [00,01,02,03,04,05,06,07,08,09,10,11,12,13,14,15,16,17,18,19,20,21,22,23].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                //width: MediaQuery.of(context).size.width,
                //margin: EdgeInsets.symmetric(horizontal: 1.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("$i h",style:
                      TextStyle(color:Colors.black.withOpacity(0.5),fontWeight: FontWeight.bold )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset("cloud.svg",  colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${meteo?.hourtemp[i]}°",style:
                      TextStyle(color:Colors.deepPurple,fontWeight: FontWeight.bold )),
                    ),


                  ],
                )
            );
          },
        );
      }).toList(),
    );


}

Widget parJour(date, min, max){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(date, style:
          TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 30)),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset("cloud.svg",  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(min.toString(), style:
              TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 30)),
            ),
            Text(max.toString(), style:
            TextStyle(color:Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold, fontSize: 30)),

          ],
        )
      ],
    ),
  );
}