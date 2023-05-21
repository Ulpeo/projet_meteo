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