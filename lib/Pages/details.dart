import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';


class details extends StatelessWidget {
  const details({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              child: carteMeteo(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Mercredi", style:
                  TextStyle(color:Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold, fontSize: 20)),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("10°",style:
                        TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                      Text("25°",style:
                      TextStyle(color:Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold, fontSize: 20))
                    ],
                  )


                ],
              ),
            ),
            parHeure(),
            parJour(),
            parJour(),
            parJour(),
            parJour(),
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
                        Text("20%", style:
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
                        Text("20%", style:
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
                        Text("NE 40Km/h", style:
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
                        Text("20°", style:
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
  }
}

Widget carteMeteo(){
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
                      Text("20°", style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 50,),),
                    ],

                  ),
                  SizedBox(
                      height:80, width: 80,
                      child: SvgPicture.asset("cloud.svg",  colorFilter: ColorFilter.mode(Colors.deepPurple, BlendMode.srcIn))),

                ],
              ),
              Text("Aujourd’hui, le temps est ensoleillé. Il y aura une minimale de 15° et un maximum de 20°.",
                  style:
                  TextStyle(fontSize: 20)),
            ],
          ),
        ),
    ),
  );
}

Widget parHeure(){
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
                      child: Text("20°",style:
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

Widget parJour(){
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Mercredi", style:
          TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 30)),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset("cloud.svg",  colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("10°", style:
              TextStyle(color:Colors.black, fontWeight: FontWeight.bold, fontSize: 30)),
            ),
            Text("20°", style:
            TextStyle(color:Colors.black.withOpacity(0.5), fontWeight: FontWeight.bold, fontSize: 30)),

          ],
        )
      ],
    ),
  );
}