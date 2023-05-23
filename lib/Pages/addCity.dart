import "package:flutter/material.dart";

import "../api/localisation.dart";

class addCity extends StatefulWidget {
  @override
  _addCityState createState() => _addCityState();
}

class _addCityState extends State<addCity> {
  final albumBloc = LocaBloc();// Créez une instance de votre classe BLoC
  final _controller = TextEditingController();



  @override
  void initState() {
    super.initState();
    albumBloc.fetchLoca2(_controller); // Appelez la méthode pour récupérer l'album lorsque votre page est initialisée
  }

  @override
  void dispose() {
    albumBloc.dispose(); // Disposez de votre classe BLoC lorsque la page est supprimée
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _controller = TextEditingController();

    void handleButtonPress() {
      String userInput = _controller.text; // Récupérez la valeur saisie par l'utilisateur à partir du contrôleur de texte
      albumBloc.fetchLoca2(userInput); // Passez la variable userInput à la méthode fetchAlbum()
      print(userInput);
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
          /*Text('Latitude: ${album?.latitude}, Longitude: ${album?.longitude}'),*/
          /*ElevatedButton(
            onPressed: handleButtonPress, // Appeler la méthode handleButtonPress() lorsque le bouton est pressé
            child: Text('Rechercher'),
          ),*/
          StreamBuilder<Loca>(
          stream: albumBloc.albumStream, // Écoutez le flux de l'album de votre classe BLoC
          builder: (context, snapshot) {
          if (snapshot.hasData) {
          final album = snapshot.data; // Récupérez l'album depuis le snapshot

          // Utilisez les données de l'album dans votre interface utilisateur
          return Text('Latitude: ${album?.latitude}, Longitude: ${album?.longitude}');
          } else if (snapshot.hasError) {
          // Gérez les erreurs lors de la récupération de l'album
          return Text('Erreur : ${snapshot.error}');
          }

          // Affichez un indicateur de chargement si aucune donnée n'est disponible
          return CircularProgressIndicator();
          },
          ),
              ],
      ),

    );


  }
}






/*class addCity extends StatelessWidget {
  const addCity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Ajouter une ville", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}*/
