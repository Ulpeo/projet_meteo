import "package:flutter/material.dart";

class addCity extends StatelessWidget {
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
}
