

import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';

const List villes = [
  {
    "ville":"Paris, France",
    "temperature":"20",
    "meteo":"pluvieux",
    "image":"rain.svg",

  }
];

String getMeteo(weatherCode){
  var meteo;
  if (weatherCode == 0){
    meteo = "ensoleillé";
  }
  else if (weatherCode==1 || weatherCode == 2 || weatherCode == 3){
    meteo = "nuageux";
  }
  else if (weatherCode == 45 || weatherCode == 48) {
    meteo = "brouillard et givre";
  } else if (weatherCode == 51 || weatherCode == 53 || weatherCode == 55) {
    meteo =  "bruine";
  } else if (weatherCode == 56 || weatherCode == 57) {
    meteo = "bruine verglaçante";
  } else if (weatherCode == 61 || weatherCode == 63 || weatherCode == 65) {
    meteo = "pluie";
  } else if (weatherCode == 66 || weatherCode == 67) {
    meteo = "pluie verglaçante";
  } else if (weatherCode == 71 || weatherCode == 73 || weatherCode == 75) {
    meteo = "chute de neige";
  } else if (weatherCode == 77) {
    meteo = "grains de neige";
  } else if (weatherCode == 80 || weatherCode == 81 || weatherCode == 82) {
    meteo = "averses";
  } else if (weatherCode == 85 || weatherCode == 86) {
    meteo = "neige";
  } else if (weatherCode == 95) {
    meteo = "orage";
  } else if (weatherCode == 96 || weatherCode == 99) {
    meteo = "orage avec grêle";
  } else {
    meteo = "inconu";
  }
  return meteo;
}

String getImage(meteo){
  var image;
  if (meteo=="ensoleillé"){
    image = "sunlight.svg";
  }
  else if (meteo == "nuageux"){
    image = "cloud.svg";
  }
  else if (meteo == "brouillard et givre"){
    image = "haze.svg";
  }
  else if (meteo == "bruine"){
    image = "rain-drops-1.svg";
  }
  else if (meteo == "bruine verglaçante"){
    image = "snow-3.svg";
  }
  else if (meteo == "pluie"){
    image = "rain.svg";
  }
  else if (meteo == "pluie verglaçante"){
    image = "snow-3.svg";
  }
  else if (meteo == "chute de neige"){
    image = "snow.svg";
  }
  else if (meteo == "grains de neige"){
    image = "snow-3.svg";
  }
  else if (meteo == "averses"){
    image = "rain-4.svg";
  }
  else if (meteo == "orage"){
    image = "thunderstorm.svg";
  }
  else if (meteo == "neige"){
    image = "snow-2.svg";
  }
  else if (meteo == "orage avec grêle"){
    image = "thunderstorm.svg";
  }
  else{
    image = "direction-1.svg";
  }

  return image;
}

Widget carte(index){
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
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(villes[index]["ville"], style:
                    TextStyle(fontSize: 25),),
                  Text(villes[index]["temperature"]+"°C",
                  style:
                    TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                    ),),
                  Text(villes[index]["meteo"], style:
                    TextStyle(fontSize: 20, color: Colors.grey),),
                ],

              ),
              SizedBox(
                height:80, width: 80,
                  child: SvgPicture.asset(villes[index]["image"],  colorFilter: ColorFilter.mode(Colors.deepPurple, BlendMode.srcIn))),
            ],
          ),
      ),

    ),
  );
}