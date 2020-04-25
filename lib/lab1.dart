import 'package:flutter/material.dart';

class Lab1 extends StatefulWidget{
  @override
  _LabOne createState()=> _LabOne();
}

class _LabOne extends State<Lab1>{
  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(242, 242, 242, 1),
        leading: BackButton(
          color: Colors.black,
        ),
        title: Text('Lab 1', 
          style:TextStyle(
            color: Colors.black,
          ),
          ),
      ),
    );
  }
}