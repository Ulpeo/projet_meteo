import 'dart:convert';

import "package:flutter/material.dart";
import "components.dart";
import 'package:http/http.dart' as http;


class MeteoPage extends StatelessWidget {
  const MeteoPage({Key? key}) : super(key: key);


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
          IconButton(
            icon: Icon(Icons.add,
                color: Colors.black,
                size: 50),
            onPressed: (){
              Navigator.pushNamed(context, '/addCity');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: villes.length,
          itemBuilder: (context, index){

            return carte(index);
          })



    );
  }
}
