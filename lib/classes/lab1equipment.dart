import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

class Lab1Equipment extends StatelessWidget {
  Lab1Equipment({this.eq1name,this.colour});
    final String eq1name;
    final Color colour;

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      height: 65,
      width: 150,
      borderRadius: 15,
      color: colour,
      child:  Center(
        child: Text(eq1name,
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