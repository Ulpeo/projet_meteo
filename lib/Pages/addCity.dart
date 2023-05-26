import "package:flutter/material.dart";
import "package:projet_meteo/Pages/MeteoPage.dart";
import "../api/localisation.dart";
import "components.dart";


//page pour ajouter la ville

class addCity extends StatefulWidget {
  final List<City> cityList; //liste de l'object de la classe City pour récupérer les infos dans toutes les pages
  addCity ({required this.cityList});
  @override
  _addCityState createState() => _addCityState();
}

class _addCityState extends State<addCity> {
  final locaBloc = LocaBloc();//
  final _controller = TextEditingController();



  @override
  void initState() {
    super.initState();
    locaBloc.fetchLoca2(_controller);
  }

  @override
  void dispose() {
    locaBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    void handleButtonPress() {

      String userInput = _controller.text;
      locaBloc.fetchLoca2(userInput);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFFF8F8F8),
        title: Text("Ajouter une ville",
            style: TextStyle(
              fontSize:30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              //obscureText: true,
              style: TextStyle(color: Colors.black,),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color:const Color(0xFF5600FF)),
                hintText: "Saisissez le nom d'une ville",
                labelStyle: TextStyle(color: Colors.grey,),
                filled: true,
                fillColor: const Color(0xFFD8D8D8),


              ),

              onSubmitted: (String value){
                handleButtonPress();

              },
            ),
          ),

          StreamBuilder<Loca>(
          stream: locaBloc.locaStream,
          builder: (context, snapshot) {
          //List<City> cities =[];
          if (snapshot.hasData) {
          final album = snapshot.data;
          City city = City(
            name: _controller.text,
            latitude: album?.latitude,
            longitude: album?.longitude,

          );
          widget.cityList.add(city);


          return Column(
            children: [
              //Text('Latitude: ${album?.latitude}, Longitude: ${album?.longitude}'),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MeteoPage(cityList: widget.cityList),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.deepPurple),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                ),
                child: Text("Voir la méteo"),
              )

            ],
          );
          } else if (snapshot.hasError) {

          return Text('');//'Erreur : ${snapshot.error}');
          }

          return CircularProgressIndicator();
          },
          ),
              ],
      ),

    );


  }
}






