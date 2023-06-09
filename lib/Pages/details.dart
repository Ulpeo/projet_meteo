import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:projet_meteo/Pages/components.dart';

import '../api/meteo.dart';

//Page de détail de la meteo avec gestion bloc + fonction pour transformer la date en jour de la semaine

String getDayOfWeek(String dateStr) {
  initializeDateFormatting('fr_FR', null);
  DateTime date = DateFormat("yyyy-MM-dd").parse(dateStr);
  String dayOfWeek = DateFormat.EEEE('fr_FR').format(date);
  dayOfWeek = dayOfWeek.substring(0, 1).toUpperCase() + dayOfWeek.substring(1);
  return dayOfWeek;
}



class details extends StatefulWidget {
  final City city; //liste de l'object de la classe City pour récupérer les infos dans toutes les pages
  details ({required this.city});
  @override
  _detailsState createState() => _detailsState(); //gestion de l'état
}

class _detailsState extends State<details> {
  final meteoBloc = MeteoBloc();

  @override
  void initState() {
    super.initState();
    meteoBloc.fetchMeteo2(widget.city.latitude,widget.city.longitude );
  }

  @override
  void dispose() {
    meteoBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    int hour = now.hour;
    print(hour);

    return StreamBuilder<Meteo>(
      stream: meteoBloc.albumStream,
      builder: (context, snapshot) {


        if (snapshot.hasData) {
          final meteo = snapshot.data;
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Color(0xFFF8F8F8),
              leading: IconButton(
                icon: Icon(Icons.arrow_circle_left, color: Colors.black, size: 50),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text(widget.city.name,
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
                    child: carteMeteo(meteo?.temperature, meteo?.min[0], meteo?.max[0], meteo?.weathercode),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Text(getDayOfWeek(meteo?.time[0]), style:
                        TextStyle(color:Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold, fontSize: 30)),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("${meteo?.min[0]}°",style:
                              TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 30)),
                            ),
                            Text("${meteo?.max[0]}°",style:
                            TextStyle(color:Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold, fontSize: 30))
                          ],
                        )


                      ],
                    ),
                  ),
                  parHeure(snapshot.data, meteo?.hourcode),
                  parJour(getDayOfWeek(meteo?.time[1]),meteo?.min[1],meteo?.max[1], meteo?.daycode[1]),
                  parJour(getDayOfWeek(meteo?.time[2]),meteo?.min[2],meteo?.max[2], meteo?.daycode[2]),
                  parJour(getDayOfWeek(meteo?.time[3]),meteo?.min[3],meteo?.max[3], meteo?.daycode[3]),
                  parJour(getDayOfWeek(meteo?.time[4]),meteo?.min[4],meteo?.max[4], meteo?.daycode[4]),
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



Widget carteMeteo(temperature, min, max, weatherCode){
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
                      Text(getMeteo(weatherCode), style:
                      TextStyle(fontSize: 20, color: Colors.grey),),
                      Text(temperature.toString()+"°C", style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50,),),
                    ],

                  ),
                  SizedBox(
                      height:73, width: 73,
                      child: SvgPicture.asset(getImage(getMeteo(weatherCode)),  colorFilter: ColorFilter.mode(Colors.deepPurple, BlendMode.srcIn))),

                ],
              ),
              Text.rich( TextSpan(
                  text:"Aujourd’hui, le temps est ",
                  style: TextStyle(fontSize: 20),
              children:[
                TextSpan( text: '${getMeteo(weatherCode)}', style:TextStyle(fontSize: 20, color: Colors.deepPurple)),
                  TextSpan( text: ' . Il y aura une minimale de ', style:TextStyle(fontSize: 20, color: Colors.black)),
          TextSpan( text: '${min}', style:TextStyle(fontSize: 20, color: Colors.deepPurple),),
          TextSpan( text: '°C et un maximum de ', style:TextStyle(fontSize: 20, color: Colors.black)),
          TextSpan( text: '${max}', style:TextStyle(fontSize: 20, color: Colors.deepPurple)),
          TextSpan( text: '°C.', style:TextStyle(fontSize: 20, color: Colors.black)),




              ]),

              ),
          ],
          ),
        ),
    ),
  );
}

Widget parHeure(meteo, weatherCode){

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
                      TextStyle(color:Colors.black.withOpacity(0.5),fontWeight: FontWeight.bold , fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SvgPicture.asset(getImage(getMeteo(weatherCode[i])),  colorFilter: ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("${meteo?.hourtemp[i]}°",style:
                      TextStyle(color:Colors.deepPurple,fontWeight: FontWeight.bold, fontSize: 15 )),
                    ),


                  ],
                )
            );
          },
        );
      }).toList(),
    );


}

Widget parJour(date, min, max, weatherCode){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(date, style:
          TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(getImage(getMeteo(weatherCode)),  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(min.toString()+'°C', style:
              TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 25)),
            ),
            Text(max.toString()+'°C', style:
            TextStyle(color:Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold, fontSize: 25)),

          ],
        )
      ],
    ),
  );
}