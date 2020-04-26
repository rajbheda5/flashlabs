import 'package:flutter/material.dart';
import 'package:clay_containers/clay_containers.dart';

class LabNumber extends StatelessWidget {
  LabNumber({this.number});
  final int number;

  @override
  Widget build(BuildContext context) {
    return ClayContainer(
      height: 150,
      width: 150,
      color: Color.fromRGBO(24, 26, 30, 1),
      borderRadius: 25,
      child: Center(
        child: Text('Lab\n  $number',
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}