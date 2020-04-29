import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

class Lab3Equipment extends StatelessWidget {
  Lab3Equipment({this.eq3name,this.colour});
    final String eq3name;
    final Color colour;

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      height: 150,
      width: 150,
      borderRadius: 15,
      color: colour,
      child:  Center(
        child: Text(eq3name,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
        ),
      ),
    );
  }
}