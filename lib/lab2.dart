import 'package:flutter/material.dart';

class Lab2 extends StatefulWidget{
  @override
  _LabTwo createState()=> _LabTwo();
}

class _LabTwo extends State<Lab2>{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text('Lab 2', 
          style:TextStyle(
            color: Colors.black,
          ),
          ),
      ),
    );
  }
}