
import "package:flutter/material.dart";
import 'addCity.dart';
import "components.dart";

//Page qui affiche les cartes raccourci


class MeteoPage extends StatelessWidget {
  final List<City> cityList; //liste de l'object de la classe City pour récupérer les infos dans toutes les pages
  const MeteoPage({Key? key,required this.cityList}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Color(0xFFC4C4C4).withOpacity(0.1),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8F8F8),
        elevation: 0,
        title: Text("Mes villes",
            style: TextStyle(
              fontSize:30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 25, 0),
            child: IconButton(
              icon: Icon(Icons.add,
                  color: Colors.black,
                  size: 50),
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => addCity(cityList: cityList),
                ),);
              },
            ),
          ),
        ],
      ),
      body: carte(cityList),




    );
  }
}
